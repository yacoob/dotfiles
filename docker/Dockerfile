# Disable lint warning about merging consecutive `RUN` lines; I squash the layers at the end regardless,
# and simpler `RUN` files cache better.
# hadolint global ignore=DL3059

FROM debian:stable-slim AS common-builder
# Set up my user
ARG UID
ARG GID
ENV UID=${UID:-1000}
ENV GID=${GID:-1000}
RUN groupadd -g ${GID} yacoob && \
  useradd -l -u ${UID} -g ${GID} -m -s /usr/bin/zsh -G sudo yacoob && \
  passwd -d yacoob
# Sort out locales
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_IE.UTF-8
ENV LC_COLLATE=pl_PL.UTF-8
ENV LC_CTYPE=pl_PL.UTF-8
ENV LC_MESSAGES=C
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# Install packages
WORKDIR /tmp
COPY --chown=yacoob:yacoob --chmod=755 ./docker/debconf debconf
# hadolint ignore=DL3008
RUN debconf-set-selections < /tmp/debconf && rm -f /tmp/debconf && \
  apt-get update && apt-get upgrade -y --no-install-recommends --no-install-suggests && \
  apt-get install -y --no-install-suggests --no-install-recommends \
  apt-utils locales localepurge && \
  dpkg-reconfigure --unseen-only localepurge && localepurge && \
  echo 'localepurge localepurge/use-dpkg-feature boolean true' | debconf-set-selections && \
  apt-get install -y --no-install-recommends --no-install-suggests \
  ca-certificates \
  curl \
  git \
  sudo \
  zsh && \
  apt-get clean && rm -rf /var/lib/apt/lists/*
RUN usermod -a -G sudo yacoob
# Run a custom script on container start
COPY --chown=yacoob:yacoob --chmod=755 ./docker/entry.sh /home/yacoob/.entry.sh
# The context should contain the entire repository.
ARG BOOTSTRAP=/tmp/conf-bootstrap
COPY --chown=yacoob:yacoob . ${BOOTSTRAP}


FROM common-builder AS base-builder
USER yacoob
WORKDIR /home/yacoob
# Run chezmoi install script
RUN "${BOOTSTRAP}/install.sh" --promptBool neovim=false,python=false && rm -rf "${BOOTSTRAP}"
# start zsh so antidote can install plugins
RUN  script -qec '/usr/bin/zsh -is </dev/null' /dev/null


FROM common-builder AS nvim-builder
USER yacoob
WORKDIR /home/yacoob
# Run chezmoi install script
RUN "${BOOTSTRAP}/install.sh" --promptBool neovim=true,python=false && rm -rf "${BOOTSTRAP}"
# bootstrap zsh plugins
RUN script -qec '/usr/bin/zsh -is </dev/null' /dev/null
# set APPIMAGE_EXTRACT_AND_RUN to avoid /dev/fuse dependency during runtime.
RUN echo 'export APPIMAGE_EXTRACT_AND_RUN=1' >> .zshenv.local
# bootstrap neovim plugins
RUN APPIMAGE_EXTRACT_AND_RUN=1 ./.local/bin/nvim -c 'Lazy install' -c 'qa!'


FROM debian:stable-slim AS common
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
# entry.sh adjusts the uid/gid at runtime, then execs sudo -u yacoob
# hadolint ignore=DL3002
USER root
ENTRYPOINT ["/home/yacoob/.entry.sh"]


FROM common AS base
COPY --from=base-builder / /


FROM common AS nvim
COPY --from=nvim-builder / /
