# Umask
umask 027

# Load zsh modules and builtins, configure them.
autoload run-help
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
autoload -U zmv

# Load user functions.
fpath=(~/.zsh/functions* ~/.zsh/completion $fpath)
autoload -U -- ~/.zsh/functions*/*(:t)

# Configure ZLE.
bindkey -v
# vi mode indicator in prompt.
# zle -N zle-line-init
# zle -N zle-keymap-select
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
# one more Esc key won't hurt
bindkey -M viins 'jj' vi-cmd-mode
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
PERIOD=300
add-zsh-hook periodic conf-prompt-helper
add-zsh-hook precmd precmd_term_title
add-zsh-hook preexec preexec_term_title

# Define aliases.
alias apt-list-backports='aptitude search -t $(lsb_release -sc)-backports -F "%p %v -> %V" "~U ~Abackports"'
alias beetsdocker='docker compose -f ~/.local/bin/beets/compose.yaml run --rm yacoob/beets'
alias cd...='cd ../..'
alias cd..='cd ..'
alias cd/='cd /'
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
alias ls='ls --color=auto'
alias mkdir='nocorrect mkdir'
alias mmv='noglob zmv -W'
alias mosh-kill-other='kill $(ps --no-headers --sort=start_time -C mosh-server -o pid | head -n -1)'
alias mv='nocorrect mv -i'
alias please='sudo $(fc -Lln -1)'
alias po=popd
alias pu=pushd
alias pwgl='pwgen -c -n -y -s -B 30 1'
alias pwg='pwgen -c -n -y -s -B 12 1'
alias rdlbf='find . -iname \*~ | xargs rm -f'
alias rezsh='nocorrect exec $SHELL'
alias rm='rm -i'
alias sfcp='rsync -i -rltgoD'
alias sudosh='nocorrect sudo -Es'
alias vew='source /etc/bash_completion.d/virtualenvwrapper'
alias zmv='noglob zmv'
if (( $+commands[vim] )); then
  alias vi=vim
fi

alias -g G="egrep"
alias -g H='|head'
alias -g L='|less'
alias -g T='|tail'

# Configure tab-completion.
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':completion:*' use-cache on
zstyle ':completion:*' verbose yes
zstyle ':completion::complete:cd::' tag-order '! users' -
zstyle ':completion::complete:-command-::' tag-order '! users' -
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:*:*:*:hosts' list-colors '=*=30;41'
zstyle ':completion:*:kill:*:processes' command "ps x"
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'

# Pull in plugins.
if [[ -r ~/.antidote/antidote.zsh ]]; then
  source ~/.antidote/antidote.zsh
  antidote load ~/.zsh/plugins.txt

  # zsh-syntax-highlighting
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
  ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
fi

# agkozak prompt - always display host
psvar[1]="@${(%):-%m}"

# fzf
if (( $+commands[fzf] )); then
  zstyle ':fzf-tab:*' switch-group '<' '>'
  source ~/.zsh/fzf-key-bindings.zsh
fi

# machine specific config
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local

# Initialize tabcompletion if it hasn't been initialised already.
if ! whence compdef >/dev/null; then
  autoload -Uz compinit
  [[ -d "${ZDOTDIR:-$HOME}/.zcompdumps" ]] || mkdir -m 0700 -p "${ZDOTDIR:-$HOME}/.zcompdumps"
  compinit -i -d "${ZDOTDIR:-$HOME}/.zcompdumps/${HOST%%.*}-$ZSH_VERSION"
  compdefas git confgit
  autoload -Uz bashcompinit
  bashcompinit
fi

# For a local session: try to use keychain to manage a local ssh-agent.
if [[ -z "${SSH_CONNECTION}" ]]; then
  if (( $+commands[keychain] )); then
    # Do we already have an ssh-agent running?
    if ps uxwww | grep -q 'ssh-agen[t]'; then
      # Yes; read keychain's information about it, and hope for it not to be stale :D
      update-ssh-auth-sock-from-keychain
    else
      # No; use keychain to start a new agent.
      eval $(keychain --eval --agents ssh --nogui ~/.ssh/id_*~*.ssh/*.*)
    fi
  fi
fi

# A dummy command that returns positive exit status to make prompt non-red :)
:
