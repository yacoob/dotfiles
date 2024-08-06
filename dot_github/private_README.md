```shell
apt update && apt install --yes --no-install-recommends ca-certificates fzf git vcsh zsh \
  && git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote \
  && vcsh clone -b main https://github.com/yacoob/dotfiles dotfiles \
  && exec zsh
```
