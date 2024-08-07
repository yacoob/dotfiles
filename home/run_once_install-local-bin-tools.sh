#!/bin/sh
set -eu
cd ~/.local/bin
curl https://zyedidia.github.io/eget.sh | sh
eg=~/.local/bin/eget
${eg} BurntSushi/ripgrep
${eg} ClementTsang/bottom -a gnu.tar -f btm
${eg} jesseduffield/lazygit
${eg} junegunn/fzf -a amd64.tar
${eg} neovim/neovim -a appimage
${eg} newren/git-filter-repo
${eg} sharkdp/bat -a gnu.tar
${eg} sharkdp/fd -a gnu.tar
${eg} starship/starship -a gnu.tar
${eg} watchexec/watchexec -a gnu.tar -a '^b3' -a '^sha512'
${eg} wfxr/forgit -f bin/git-forgit
${eg} Wilfred/difftastic
ln -fs nvim vim
ln -fs vim vi
