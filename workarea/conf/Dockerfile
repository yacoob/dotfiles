FROM debian:stable-slim AS builder
# Sort out locales
COPY workarea/conf/debconf debconf
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
  bat \
  ca-certificates \
  curl \
  fd-find \
  file \
  fzf \
  git \
  less \
  openssh-client \
  pv \
  ripgrep \
  sudo \
  wget \
  vcsh \
  vim-tiny \
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
RUN vcsh clone -b ${CONF_BRANCH} file:///$(pwd) dotfiles
WORKDIR /home/yacoob
RUN rm -rf ${CTX}
# Install antidote
RUN /usr/bin/git clone --depth=1 https://github.com/mattmc3/antidote.git /home/yacoob/.antidote
# Run a dummy zsh session to allow plugins to fully initialize
RUN script -qec '/usr/bin/zsh -is </dev/null' /dev/null
# Run a custom script on container start
COPY --chown=yacoob:yacoob --chmod=755 workarea/conf/entry.sh /home/yacoob/.entry.sh


FROM debian:stable-slim AS base
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


FROM base AS nvim-builder
RUN apt-get purge -y vim-tiny
WORKDIR /usr/local/bin
# Install neovim appimage; I want at last 0.10, all Debian packages are 0.9 or older.
# APPIMAGE_EXTRACT_AND_RUN is set to avoid /dev/fuse dependency during runtime.
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
  && chmod a+rx nvim.appimage && ln -s nvim.appimage nvim && ln -s nvim vim && ln -s nvim vi
USER yacoob
RUN echo 'export APPIMAGE_EXTRACT_AND_RUN=1' >> /home/yacoob/.zshenv.local
# Install neovim plugins
RUN APPIMAGE_EXTRACT_AND_RUN=1 /usr/local/bin/nvim -c 'Lazy install' -c 'qa!'


FROM base AS nvim
COPY --from=nvim-builder / /
