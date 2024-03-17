FROM debian:stable-slim AS minimal
ARG DEBIAN_FRONTEND=noninteractive

# Sort out locales.
COPY workarea/conf/docker/debconf debconf
ENV LANG=en_IE.UTF-8
ENV LC_COLLATE=pl_PL.UTF-8
ENV LC_CTYPE=pl_PL.UTF-8
ENV LC_MESSAGES=C
RUN cat debconf | debconf-set-selections && rm -f debconf && \
    apt-get update && apt-get upgrade -y --no-install-recommends && \
    apt-get install -y --no-install-recommends apt-utils locales localepurge && \
    dpkg-reconfigure --unseen-only localepurge && localepurge && \
    echo 'localepurge localepurge/use-dpkg-feature boolean true' | debconf-set-selections && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      file \
      fzf \
      git \
      less \
      nvi \
      openssh-client \
      ripgrep \
      silversearcher-ag \
      sudo \
      wget \
      zsh \
      zsh-antigen \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up my user.
ARG UID
ARG GID
ENV UID=${UID:-1026}
ENV GID=${GID:-65537}
RUN groupadd -g ${GID} yacoob && \
    useradd -u ${UID} -g ${GID} -m -s /usr/bin/zsh -G sudo yacoob && \
    passwd -d yacoob
USER yacoob

FROM minimal as base
# Set the environment.
ENV SHELL=/usr/bin/zsh
ENV TERM=xterm-256color
ENV TZ='Europe/Dublin'
ENV SSH_AUTH_SOCK=/home/yacoob/.ssh/agent.sock

# Set up the dotfiles.
ARG CTX=/tmp/conf-bootstrap
# Copy the entire context, which should be our conf repo to a tmp directory.
COPY --chown=yacoob:yacoob . ${CTX}
WORKDIR ${CTX}
# Initialize dotfiles, using that tmp directory as a remote repo.
ARG CONF_BRANCH
ARG REPO_IS_DETACHED
RUN BRANCH=${CONF_BRANCH} REPO_IS_DETACHED=${REPO_IS_DETACHED} REPO_PULL_URL=file:///$(pwd) \
      workarea/conf/init.sh && \
      rm -rf ${CTX}
WORKDIR /home/yacoob

# Install all zsh plugins.
RUN /usr/bin/zsh /home/yacoob/.zsh/antigen-plugins
# Run a dummy zsh session to allow plugins to fully initialize.
RUN script -qec '/usr/bin/zsh -is </dev/null' /dev/null
# Run the shell.
ENTRYPOINT ["/usr/bin/zsh", "--login"]

FROM base as vim
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
      vim-nox \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
# Install all vim plugins.
USER yacoob
RUN script -qec "/usr/bin/vim -T dumb -c 'PlugInstall' -c 'qa!' >/dev/null" /dev/null
