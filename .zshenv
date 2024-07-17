# No duplicates in  variables specified below.
typeset -U path manpath
# reset PATH (unles asked otherwise) to ensure sane baseline for it
[[ -z "${__PRESERVE_PATH}" ]] && path=()
path=(/usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin $path[@])
path=(~/.local/bin $path[@])

# conf repo updater
export CONF_AUTO_UPDATE=true
export CONF_STALE_IF_OLDER_THAN=$(( 60 * 60 * 24 * 2 ))  # 2d in seconds

# locales
export LANG=en_IE.UTF-8
export LC_COLLATE=pl_PL.UTF-8
export LC_CTYPE=pl_PL.UTF-8
export LC_MESSAGES=C
export TZ='Europe/Dublin'

# general
export CVS_RSH=ssh
export EMAIL="yacoob@ftml.net"
export TMPDIR=/tmp
if (( $+commands[vim] )); then
  export EDITOR=vim
  export VISUAL=vim
elif (( $+commands[vi] )); then
  export EDITOR=vi
  export VISUAL=vi
fi

# golang settings
export GOPATH="${HOME}/workarea/golang"

# less
export LESS="-iSRM"
export LESSCHARSET="utf-8"
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode – red
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode – bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m')     # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_ue=$(printf '\e[0m')     # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode – cyan

# python settings
export PIP_REQUIRE_VIRTUALENV=true
export WORKON_HOME="${HOME}/.venvs"
export PIPENV_VENV_IN_PROJECT=1

# zsh-syntax-highlighting
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
export ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

# WSL marker for distros other than Debian
if [[ -n "${WSL_DISTRO_NAME}" && "${WSL_DISTRO_NAME}" != "Debian" ]]; then
  export WSL_PROMPT_DISTRO_NAME="${WSL_DISTRO_NAME}"
fi

# highlight
if (( $+commands[highlight] )); then
  export LESSOPEN="| $(which highlight) --force --quiet %s"
  export HIGHLIGHT_OPTIONS="-O truecolor -s zmrok"
fi

# delta
if (( $+commands[delta] )); then
  export GIT_PAGER=delta
fi

# fzf
if (( $+commands[fzf] )); then
  export FZF_DEFAULT_OPTS='--height ~40% --reverse --inline-info --ansi'
fi

# fd
if (( $+commands[fdfind] )); then
  export FZF_DEFAULT_COMMAND="fdfind --type file --color=always"
elif (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND="fd --type file --color=always"
fi

# nvm
if [[ -d ~/.nvm ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# machine specific config
[[ -r ~/.zshenv.local ]] && source ~/.zshenv.local
