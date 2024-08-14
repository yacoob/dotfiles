FROM debian:stable-slim AS common-builder
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
RUN debconf-set-selections < ./docker/debconf && rm -f debconf && \
  apt-get update && apt-get upgrade -y --no-install-recommends --no-install-suggests && \
  apt-get install -y --no-install-suggests --no-install-recommends \
  apt-utils locales localepurge && \
  dpkg-reconfigure --unseen-only localepurge && localepurge && \
  echo 'localepurge localepurge/use-dpkg-feature boolean true' | debconf-set-selections && \
  apt-get install -y --no-install-recommends --no-install-suggests \
  ca-certificates \
  curl \
  git \
  sudo && \
  apt-get clean && rm -rf /var/lib/apt/lists/* && \
  usermod -a -G sudo yacoob


FROM common-builder AS base-builder
# Run chezmoi install script
USER yacoob
WORKDIR /home/yacoob
RUN "${BOOTSTRAP}/install.sh" --promptBool neovim=false && \
  script -qec '/usr/bin/zsh -is </dev/null' /dev/null
# Run a custom script on container start
COPY --chown=yacoob:yacoob --chmod=755 ./docker/entry.sh .entry.sh


FROM common-builder AS nvim-builder
USER yacoob
WORKDIR /home/yacoob
RUN "${BOOTSTRAP}/install.sh" --promptBool neovim=true && \
  script -qec '/usr/bin/zsh -is </dev/null' /dev/null
# Run a custom script on container start
COPY --chown=yacoob:yacoob --chmod=755 ./docker/entry.sh .entry.sh
# APPIMAGE_EXTRACT_AND_RUN is set to avoid /dev/fuse dependency during runtime.
RUN echo 'export APPIMAGE_EXTRACT_AND_RUN=1' >> .zshenv.local && \
  APPIMAGE_EXTRACT_AND_RUN=1 ./.local/bin/nvim -c 'Lazy install' -c 'qa!'


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
