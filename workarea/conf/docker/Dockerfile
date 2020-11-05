FROM debian:stable-slim AS base
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Sort out locales.
COPY workarea/conf/docker/debconf debconf
RUN cat debconf | debconf-set-selections && rm -f debconf
RUN apt-get update && apt-get install -y apt-utils locales localepurge && \
    dpkg-reconfigure --unseen-only localepurge && localepurge && \
    echo 'localepurge localepurge/use-dpkg-feature boolean true' | debconf-set-selections && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
ENV LANG=en_IE.UTF-8
ENV LC_COLLATE=pl_PL.UTF-8
ENV LC_CTYPE=pl_PL.UTF-8
ENV LC_MESSAGES=C

# Convenience tooling.
RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      file \
      fzf \
      git \
      less \
      nvi \
      openssh-client \
      silversearcher-ag \
      sudo \
      wget \
      zsh \
      zsh-antigen \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up my user.
RUN groupadd -g 1000 yacoob
RUN useradd -u 1000 -g 1000 -m -s /usr/bin/zsh -G sudo yacoob && passwd -d yacoob
USER yacoob

# Set the environment.
ENV SHELL=/usr/bin/zsh
ENV TERM=xterm-256color
ENV TZ='Europe/Dublin'
ENV SSH_AUTH_SOCK=/home/yacoob/.ssh/agent.sock

# Set up the dotfiles.
ENV OS=linux
ENV LOCATION=home
ARG CTX=/tmp/conf-bootstrap
# Copy the entire context, which should be our conf repo to a tmp directory.
COPY --chown=yacoob:yacoob . ${CTX}
WORKDIR ${CTX}
# Initialize dotfiles, using that tmp directory as a remote repo.
RUN BRANCH=$(git rev-parse --abbrev-ref HEAD) REPO_PULL_URL=$(pwd) workarea/conf/init.sh && \
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
