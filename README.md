# my config files in chezmoi flavour

[![Build and push image to Docker Hub](https://github.com/yacoob/dotfiles/actions/workflows/docker.yaml/badge.svg?branch=main&event=push)](https://github.com/yacoob/dotfiles/actions/workflows/private_docker-image.yml)

## next

- generate tabcompletions for egetted binaries

## Installation

As root:

```shell
apt update && \
apt install --yes --no-install-recommends curl sudo && \
usermod -a -G sudo yacoob
```

As me:

```shell
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply yacoob
```
