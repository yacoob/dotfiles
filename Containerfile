# hadolint global ignore=DL3007,DL3041,DL3059,DL4006
# - 3007 - yes, I do want the `latest` :D
# - 3041 - no, I don't care about specific versions of the packages I'm installing
# - 3059 - I'm ok with consecutive `RUN`s; I squash the layers at the end regardless,
#          and during the build multiple `RUN` lines cache better
# - 4006 - podman doesn't support this :[

FROM fedora:latest AS base-builder
# Set up my user
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} yacoob \
  && useradd -l -u ${UID} -g ${GID} -m -s /usr/bin/fish -G wheel yacoob \
  && passwd -d yacoob

# Install packages
RUN \
  dnf5 install --setopt=install_weak_deps=False -y \
  chezmoi \
  curl \
  fd-find \
  fish \
  fzf \
  git \
  procps \
  psmisc \
  ripgrep \
  sudo \
  util-linux-script \
  which \
  && dnf5 clean all

# Install extra binaries
RUN curl -sS https://starship.rs/install.sh | sh

# remove unused locales
RUN \
  find /usr/share/locale -maxdepth 1 -type d \
  ! -name 'en' \
  ! -name 'en_IE' \
  ! -name 'pl' \
  ! -name 'pl_PL' \
  -exec rm -rf {} +

# install chezmoi_modify_manager system-wide - it's needed for
# a successful chezmoi run
RUN \
  TAG=$(curl -sI https://github.com/VorpalBlade/chezmoi_modify_manager/releases/latest \
  | grep -i ^location \
  | sed 's|.*/tag/||' \
  | tr -d '[:space:]') \
  && curl -sL "https://github.com/VorpalBlade/chezmoi_modify_manager/releases/download/${TAG}/chezmoi_modify_manager-${TAG}-x86_64-unknown-linux-gnu.tar.gz" \
  | tar -xzC /usr/local/bin chezmoi_modify_manager

# set up dotfiles via chezmoi
USER yacoob
WORKDIR /home/yacoob
# The context should contain the entire repository.
COPY --chown=yacoob:yacoob . /home/yacoob/.local/share/chezmoi
# Run chezmoi install script
RUN ./.local/share/chezmoi/install.sh

# start the shell so it can install plugins
RUN script -qec '/usr/bin/fish -i </dev/null' /dev/null



FROM base-builder AS devenv-builder
USER root

# Add more packages
RUN \
  dnf5 install --setopt=install_weak_deps=False -y \
  bat \
  git-credential-oauth \
  git-delta \
  just \
  neovim \
  nodejs-npm \
  unzip \
  util-linux \
  && dnf5 clean all

# Install extra binaries
RUN curl https://mise.run | sh

# install some binaries via mise
USER yacoob
WORKDIR /home/yacoob
RUN \
  mise use -g \
  jj \
  jjui \
  && mise cache prune



FROM fedora:latest AS base
COPY --from=base-builder / /
# Set the environment
ENV SHELL=/usr/bin/fish
ENV SSH_AUTH_SOCK=/home/yacoob/.ssh/agent.sock
ENV TERM=xterm-256color
ENV TZ='Europe/Dublin'
USER yacoob
WORKDIR /home/yacoob
ENTRYPOINT ["/usr/bin/fish"]
LABEL maintainer="yacoob@ftml.net"
LABEL prompt="podman run -it --rm --userns=keep-id:uid=1000,gid=1000 --security-opt label=disable -v /home/yacoob/.ssh:/home/yacoob/.ssh:ro IMAGE"
# Add devcontainer options
# https://containers.dev/implementors/reference/#labels
LABEL devcontainer.metadata='{ \
  "remoteUser": "yacoob", \
  "containerUser": "yacoob", \
  "securityOpt": ["label=disable"] \
  }'



FROM base AS devenv
COPY --from=devenv-builder / /
