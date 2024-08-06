# my config files in chezmoi flavour

```shell
apt update && \
apt install --yes --no-install-recommends curl && \
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply --branch chezmoi yacoob
```

## next

- split tools into minimal and full set
- maybe move `~/.local/share/dotfiles-docker/`?
- update `illaoi`
- update Dockerfile
