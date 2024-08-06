# my config files in chezmoi flavour

```shell
apt update && \
apt install --yes --no-install-recommends curl && \
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply --branch chezmoi yacoob
```

## next

- install minimal set of tools: git, zsh, eget, file, less, openssh-client, pv, sudo, wget
- install nvim (w/ `/usr/local/bin` symlinks?)
- maybe move `~/.local/share/dotfiles-docker/`?
- eget other tools: bat, fdfind, ripgrep, bottom, starship, fzf, lazygit, difftastic, watchexec, forgit
- bootstrap zsh plugins
- bootstrap nvim config
- update Dockerfile
