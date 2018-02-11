source ~/.yacoob-conf
#
# No duplicates in  variables specified below.
typeset -U path manpath
# set fixed PATH
path=(/usr/local/bin /usr/bin /usr/sbin /bin /sbin)
# Handle non-standard homebrew location.
local p
foreach p (/usr/local/bin ~/brew/bin ~/.linuxbrew/bin) {
  [[ -x $p/brew ]] && export BREWPATH=${p%%/bin}
}
if [[ "${BREWPATH}" != "/usr/local" ]]; then
  path=(${BREWPATH}/bin ${BREWPATH}/sbin $path[@])
  manpath=(${BREWPATH}/share/man $(manpath))
fi
path=(~/bin $path[@])

# locales
export LANG=en_IE.UTF-8
export LC_COLLATE=pl_PL.UTF-8
export LC_CTYPE=pl_PL.UTF-8
export LC_MESSAGES=C
export LC_MESSAGES=C
export TZ='Europe/Dublin'

# misc
export CVS_RSH=ssh
export EDITOR=vim
export EMAIL="yacoob@gmail.com"
export TMPDIR=/tmp
export VISUAL=vim

# less settings
export LESS="-iSrM"
export LESSCHARSET="utf-8"
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode – red
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode – bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m')     # turn off all appearance modes (mb, md, so, us)
#export LESS_TERMCAP_se=$(printf '\e[0m')     # leave standout mode
#export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode – yellow
export LESS_TERMCAP_ue=$(printf '\e[0m')     # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode – cyan
#
# use highlight if it's installed
if (( $+commands[highlight] )); then
  export LESSOPEN="| $(which highlight) --force --quiet %s"
  export HIGHLIGHT_OPTIONS="-O truecolor -s zmrok"
fi

# fzf
if (( $+commands[fzf] )); then
  export FZF_DEFAULT_OPTS='--height 40% --reverse --border --inline-info --black'
fi

# python settings
export PIP_REQUIRE_VIRTUALENV=true
export WORKON_HOME="${HOME}/.venvs"
export PIPENV_VENV_IN_PROJECT=1

# System dependent settings
[[ -r ~/.zshenv.${OS} ]] && source ~/.zshenv.${OS}

# Location dependent confidential settings
[[ -r ~/.zshenv.${LOCATION} ]] && source ~/.zshenv.${LOCATION}
