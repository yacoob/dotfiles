source ~/.yacoob-conf

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
# use highlight if it's installed
if (( $+commands[highlight] )); then
  export LESSOPEN="| $(which highlight) %s"
fi

# highlight settings
export HIGHLIGHT_OPTIONS="--force -O truecolor -s zmrok"

# fzf
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --inline-info --black'

# *brew
export BREWPATH=~/brew

# python settings
export PIP_REQUIRE_VIRTUALENV=true
export WORKON_HOME="${HOME}/.venvs"

# System dependent settings
[[ -r ~/.zshenv.${OS} ]] && source ~/.zshenv.${OS}

# No duplicates in  variables specified below. Any attempts to add values to
# those variables will bump those values to the front of the array instead.
typeset -U path manpath
# set fixed PATH
path=(~/bin ${BREWPATH}/sbin ${BREWPATH}/bin /usr/local/bin /usr/bin /usr/sbin)
manpath=(${BREWPATH}/share/man $(manpath))

# Location dependent confidential settings
[[ -r ~/.zshenv.${LOCATION} ]] && source ~/.zshenv.${LOCATION}
