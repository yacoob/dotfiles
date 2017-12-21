source ~/.yacoob-conf

# Umask
umask 027

# Load zsh modules and builtins, configure them.
autoload run-help
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
autoload -U zmv

# vcs_info
#zstyle ':vcs_info:*+*:*' debug true
setopt promptsubst
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' stagedstr '%F{yellow}●'
zstyle ':vcs_info:*' unstagedstr '%F{red}●'
zstyle ':vcs_info:*' formats '%u%c %F{green}%b %F{default}'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' get-revision true
# Don't run vcs_info every time
zstyle ':vcs_info:*+pre-get-data:*' hooks pre-get-data

# Load user functions.
fpath=(~/.zsh/functions* ~/.zsh/completion $fpath)
autoload -U -- ~/.zsh/functions*/*(:t)

# Configure ZLE.
bindkey -v
# vi mode indicator in prompt.
zle -N zle-keymap-select
zle -N zle-line-finish
# Some vim and emacs keybindings.
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a G end-of-buffer-or-history
bindkey '^G' what-cursor-position
bindkey -a u undo
bindkey -a '^R' redo
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
# fake-enter = save to history without executing.
zle -N fake-enter; bindkey "^X^H" fake-enter
# edit in external editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
# Keycodes recorded via zkbd, as terminfo had some quirks about up/down.
# http://zshwiki.org/home/zle/bindkeys
zle -N vi-cmd-up-line-history
zle -N vi-cmd-down-line-history
massbind beginning-of-line '^[[1~'
massbind end-of-line '^[[4~'
massbind vi-cmd-up-line-history '^[[A' '^[OA'
massbind vi-cmd-down-line-history '^[[B' '^[OB'

# Setup ZSH variables.
cdpath=(. ~)
DIRSTACKSIZE=20
fignore=(\~)
LISTMAX=0
LOGCHECK=60
HISTSIZE=20000
HISTFILE=~/.zsh_history
MAILCHECK=1
READNULLCMD=less
REPORTTIME=15
SAVEHIST=20000
TIMEFMT='%J  %*U user %*S system %P cpu (%*E wasted time).'
watch=(all)
WATCHFMT='%n %a %l from %m at %t.'
WORDCHARS="${WORDCHARS:s#/#}"

# Setup ZSH options.
setopt \
  auto_cd \
  auto_name_dirs \
  auto_pushd \
  auto_resume \
  nobeep \
  cdable_vars \
  csh_null_glob \
  correct \
  correct_all \
  extended_glob \
  NO_glob_dots \
  hist_allow_clobber \
  hist_find_no_dups \
  hist_ignore_all_dups \
  hist_ignore_dups \
  hist_ignore_space \
  hist_reduce_blanks \
  HIST_save_no_dups \
  inc_append_history \
  NO_list_ambiguous \
  NO_list_beep \
  long_list_jobs \
  magic_equal_subst \
  notify \
  prompt_subst \
  pushd_minus \
  pushd_silent \
  pushd_to_home \
  rc_quotes \
  share_history \
  transient_rprompt \

# Hooks
autoload -Uz add-zsh-hook
add-zsh-hook chpwd chpwd_vcs_info
PERIOD=300
add-zsh-hook periodic conf-prompt-helper
add-zsh-hook precmd vcs_info
add-zsh-hook precmd precmd_term_title
add-zsh-hook preexec preexec_term_title
add-zsh-hook preexec preexec_vcs_info

# Set up prompts.
# Use an anonymous function to isolate local variables from user environment.
function {
  local -a plines tmp

  # First line.
  tmp+='%(!.%F{red}✖%F{default}.%F{green}❤%F{default})'
  tmp+=' [%(2L.+.)%n%F{red}@%F{default}%m%F{default}]'
  tmp+=' [%F{red}%T %w%F{default}]'
  tmp+=' [%F{yellow}%!%F{default}]'
  tmp+=' [%(?.-.%F{cyan}%?%F{default})]'
  plines+=${(j::)tmp}

  # Second line.
  plines+='[%F{cyan}%~%F{default}]'

  # Third line.
  tmp=()
  tmp+='%F{yellow}${_CMD_MODE:+☯ }%F{default}'
  tmp+='%F{cyan}${_CONF_UPDATE:+⟳  }%F{default}'
  tmp+='%(?,,%F{red})%(!.#.$)%F{default} '
  plines+=${(j::)tmp}

  # PROMPT, assemble!
  PROMPT=${(F)plines}
 }
RPROMPT=$'${vcs_info_msg_0_}'

# Define aliases.
alias cd/='cd /'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cp='nocorrect cp -i'
alias d='dirs -v'
alias dlbf='rm -f (.*~|*~)'
alias dlb='rm  -i (.*~|*~)'
alias grep='egrep --color=auto'
alias h=history
alias j=jobs
alias la='ls -A'
alias lla='ll -A'
alias lld='ls -ld *(-/DN)'
alias ll='ls -lh'
alias mkdir='nocorrect mkdir'
alias mmv='noglob zmv -W'
alias mv='nocorrect mv -i'
alias po=popd
alias pu=pushd
alias pwg='pwgen -c -n -y -s -B 12 1'
alias pwgl='pwgen -c -n -y -s -B 30 1'
alias rdlbf='find . -iname \*~ | xargs rm -f'
alias rezsh='nocorrect exec $SHELL'
alias rm='rm -i'
alias sudosh='nocorrect sudo -Es'
alias vi=vim
alias zmv='noglob zmv'

alias -g G="egrep"
alias -g H='|head'
alias -g L='|less'
alias -g T='|tail'

# Configure tab-completion.
zstyle ':completion::complete:cd::' tag-order '! users' -
zstyle ':completion::complete:-command-::' tag-order '! users' -
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:*:*:*:hosts' list-colors '=*=30;41'
zstyle ':completion:*:kill:*:processes' command "ps x"
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' verbose yes
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'

# Pull in antigen plugins.
source ~/.zsh/antigen-plugins

# binary-present? configurations
if (( $+commands[fasd] )); then
  eval "$(fasd --init auto)"
fi
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

# Pull in OS dependent settings.
case "${OS}" in
    "linux")
        alias ls='ls --color=auto'
        alias vew='source /etc/bash_completion.d/virtualenvwrapper'
        alias mosh-kill-other='kill $(ps --no-headers --sort=start_time -C mosh-server -o pid | head -n -1)'
        ;;
    "osx")
        alias ls='ls -G'
        alias vi=mvim
        alias vim=mvim
        alias vimdiff='mvim -d'
        alias vew='source $(which virtualenvwrapper.sh)'
        fpath=(${BREWPATH}/share/zsh-completions $fpath)
        ;;
esac

# Pull in location dependent settings.
[[ -r ~/.zshrc.${LOCATION} ]] && source ~/.zshrc.${LOCATION}

# A dummy command that returns positive exit status to make prompt non-red :)
: