FROM debian:stable-slim AS builder
# Set up my user
ARG UID
ARG GID
ENV UID=${UID:-1000}
ENV GID=${GID:-1000}
RUN groupadd -g ${GID} yacoob && \
  useradd -l -u ${UID} -g ${GID} -m -s /usr/bin/zsh -G sudo yacoob && \
  passwd -d yacoob
# The context should contain the entire repository.
# This also mean you should NOT build the docker image from a vcsh-managed install of the dotfiles, as it'll happily use the entire homedir for the context.
ARG BOOTSTRAP=/tmp/conf-bootstrap
COPY --chown=yacoob:yacoob . ${BOOTSTRAP}
WORKDIR ${BOOTSTRAP}
# Sort out locales
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_IE.UTF-8
ENV LC_COLLATE=pl_PL.UTF-8
ENV LC_CTYPE=pl_PL.UTF-8
ENV LC_MESSAGES=C
# Install packages
# hadolint ignore=DL3008,DL4006
RUN debconf-set-selections < .local/share/dotfiles-docker/debconf && rm -f debconf && \
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
# Use https://github.com/zyedidia/eget to fetch some binaries missing in the distro
WORKDIR /usr/local/bin
# hadolint ignore=DL4006
RUN umask 022 && curl https://zyedidia.github.io/eget.sh | sh && \
  ./eget ClementTsang/bottom -a gnu.tar -f btm && \
  ./eget dandavison/delta -a gnu.tar && \
  ./eget starship/starship -a gnu.tar && \
  ./eget wfxr/forgit -f bin/git-forgit
# Initialize dotfiles, using that tmp directory as a remote repo
USER yacoob
WORKDIR /home/yacoob
ARG CONF_BRANCH=main
# Install the dotfiles from the local repo copy
RUN vcsh clone -b ${CONF_BRANCH} "file:///${BOOTSTRAP}" dotfiles && \
  rm -rf ${BOOTSTRAP}
# Set up zsh
RUN /usr/bin/git clone --depth=1 https://github.com/mattmc3/antidote.git .antidote && \
  script -qec '/usr/bin/zsh -is </dev/null' /dev/null
# Run a custom script on container start
COPY --chown=yacoob:yacoob --chmod=755 .local/share/dotfiles-docker/entry.sh .entry.sh


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
# entry.sh adjusts the uid/gid at runtime, then execs sudo -u yacoob
# hadolint ignore=DL3002
USER root
ENTRYPOINT ["/home/yacoob/.entry.sh"]


FROM base AS nvim-builder
RUN apt-get purge -y vim-tiny
WORKDIR /usr/local/bin
# Install neovim appimage via eget; I want at last 0.10, all Debian packages are 0.9 or older.
RUN umask 022 && ./eget neovim/neovim -a appimage && ln -s vim vi && ln -s nvim vim
USER yacoob
WORKDIR /home/yacoob
# APPIMAGE_EXTRACT_AND_RUN is set to avoid /dev/fuse dependency during runtime.
RUN echo 'export APPIMAGE_EXTRACT_AND_RUN=1' >> .zshenv.local && \
  APPIMAGE_EXTRACT_AND_RUN=1 /usr/local/bin/nvim -c 'Lazy install' -c 'qa!'


FROM base AS nvim
COPY --from=nvim-builder / /
