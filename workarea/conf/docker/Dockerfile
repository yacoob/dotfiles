FROM debian:stable-slim AS builder
# Sort out locales
COPY workarea/conf/docker/debconf debconf
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_IE.UTF-8
ENV LC_COLLATE=pl_PL.UTF-8
ENV LC_CTYPE=pl_PL.UTF-8
ENV LC_MESSAGES=C
# Install packages
RUN debconf-set-selections < debconf && rm -f debconf && \
    apt-get update && apt-get upgrade -y --no-install-recommends --no-install-suggests && \
    apt-get install -y --no-install-suggests --no-install-recommends \
            apt-utils locales localepurge && \
    dpkg-reconfigure --unseen-only localepurge && localepurge && \
    echo 'localepurge localepurge/use-dpkg-feature boolean true' | debconf-set-selections && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      ca-certificates \
      curl \
      file \
      fzf \
      git \
      less \
      nvi \
      openssh-client \
      ripgrep \
      sudo \
      wget \
      zsh \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
# Set up my user
ARG UID
ARG GID
ENV UID=${UID:-1000}
ENV GID=${GID:-1000}
RUN groupadd -g ${GID} yacoob && \
    useradd -u ${UID} -g ${GID} -m -s /usr/bin/zsh -G sudo yacoob && \
    passwd -d yacoob
# Set up the dotfiles
ARG CTX=/tmp/conf-bootstrap
USER yacoob
# Copy the entire context, which should be our conf repo to a tmp directory
COPY --chown=yacoob:yacoob . ${CTX}
WORKDIR ${CTX}
# Initialize dotfiles, using that tmp directory as a remote repo
ARG CONF_BRANCH
ARG REPO_IS_DETACHED
RUN BRANCH=${CONF_BRANCH} REPO_IS_DETACHED=${REPO_IS_DETACHED} REPO_PULL_URL=file:///$(pwd) workarea/conf/init.sh
WORKDIR /home/yacoob
# Install antidote
RUN /usr/bin/git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
# Run a dummy zsh session to allow plugins to fully initialize
RUN script -qec '/usr/bin/zsh -is </dev/null' /dev/null
# Run a custom script on container start
RUN cp ${CTX}/workarea/conf/docker/entry.sh /home/yacoob/.entry.sh && rm -rf ${CTX}
COPY --chown=yacoob:yacoob --chmod=755 workarea/conf/docker/entry.sh /home/yacoob/.entry.sh


FROM debian:stable-slim as base
# Redo the envs
ARG UID
ARG GID
ENV UID=${UID:-1000}
ENV GID=${GID:-1000}
# Set the environment
ENV LANG=en_IE.UTF-8
ENV LC_COLLATE=pl_PL.UTF-8
ENV LC_CTYPE=pl_PL.UTF-8
ENV LC_MESSAGES=C
ENV SHELL=/usr/bin/zsh
ENV SSH_AUTH_SOCK=/home/yacoob/.ssh/agent.sock
ENV TERM=xterm-256color
ENV TZ='Europe/Dublin'
COPY --from=builder / /
USER root
ENTRYPOINT ["/home/yacoob/.entry.sh"]


FROM base as vim-builder
RUN apt-get update && apt-get install -y --no-install-recommends --no-install-suggests \
      vim-nox \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
# Install vim plugins
USER yacoob
RUN script -qec "/usr/bin/vim -T dumb -c 'PlugInstall' -c 'qa!' >/dev/null" /dev/null


FROM base as vim
COPY --from=vim-builder / /
