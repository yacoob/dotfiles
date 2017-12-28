source ~/.yacoob-conf

# No duplicates in  variables specified below. Any attempts to add values to
# those variables will bump those values to the front of the array instead.
# See also __path_has_been_adjusted below.
typeset -U path manpath

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

# python settings
export PIP_REQUIRE_VIRTUALENV=true
export WORKON_HOME="${HOME}/.venvs"

# System dependent settings
[[ -r ~/.zshenv.${OS} ]] && source ~/.zshenv.${OS}

# Handle variables that are being *modified* (as opposed to just set to a fixed
# value) by adding something in the front. After we modify them, we set
# a sentinel variable to avoid doing this again in child shells.
#
# Details:
# Assume 'PATH=a:b:c:$PATH' being present in a file that's read for both
# interactive and non-interactive shell startup. If you launch a child shell
# (say, from vim), PATH would end up with duplicates. If you modify $PATH during your shell runtime (for example via virtualenvwrapper), you end up with:
#
# $ PATH=venv_bin:$PATH
# $ vim
# :!echo $PATH
# a:b:c:venv_bin:a:b:c:...
#
# zsh's 'typeset -U' helps a bit with this situation - instead of adding
# duplicated elements, zsh is moving them to the front instead. Which helps for
# PATH elongation problem as long as you don't run into scenario described
# above.
#
# :!echo $PATH
# a:b:c:venv_bin:...
#
# Grrr.
#
if [[ -z ""${__path_has_been_adjusted}"" ]]; then
  case "${OS}" in
      "linux")
          path=(~/bin /usr/local/bin ${path})
          ;;
      "osx")
          path=(~/bin ${BREWPATH}/sbin ${BREWPATH}/bin /usr/local/bin ${path})
          manpath=(${BREWPATH}/share/man ${manpath})
          ;;
  esac
  export __path_has_been_adjusted=1
fi

# Location dependent confidential settings
[[ -r ~/.zshenv.${LOCATION} ]] && source ~/.zshenv.${LOCATION}
