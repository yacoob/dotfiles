umask 027

# locale
#
set -gx LANG en_IE.UTF-8
set -gx LC_COLLATE pl_PL.UTF-8
set -gx LC_CTYPE pl_PL.UTF-8
set -gx LC_MESSAGES C.UTF-8
set -gx TZ Europe/Dublin

# environment
#
set -gx EMAIL "yacoob@ftml.net"
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx LESS "-iSRM"
set -gx LIBPROC_HIDE_KERNEL 1
set -gx PIP_REQUIRE_VIRTUALENV true
set -gx SHELL $(which fish)
set -gx SSH_AUTH_SOCK ~/.1password/agent.sock
set -gx TMPDIR /tmp

# homebrew
#
if not set -q HOMEBREW_PREFIX
    if test -x /home/linuxbrew/.linuxbrew/bin/brew
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    end
end

# is this an interactive shell?
#
status is-interactive || exit 0

# variables
#
set -g fish_greeting
set -g fish_key_bindings fish_vi_key_bindings

# aliases
#
alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'rm -i'
alias grep 'egrep --color=auto'
alias ll 'ls -lh'
alias la 'ls -A'
alias lla 'll -A'
alias k kubectl
alias apt-list-backports 'aptitude search -t (lsb_release -sc)-backports -F "%p %v -> %V" "~U ~Abackports"'
alias beets-container 'podman compose -f ~/.local/bin/beets/compose.yaml pull --policy=always && podman compose -f ~/.local/bin/beets/compose.yaml run --rm beets'

# conditional settings
#

# bat
# if command -q bat
#     set -gx MANPAGER "sh -c 'awk ''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'' | bat -p -lman'"
#     set -gx LESSOPEN "|bat --color=always --style=plain %s"
# end

# eza
if command -q eza
    alias ls 'eza --colour-scale all --icons --hyperlink --group-directories-first'
else
    alias ls 'ls --color=auto'
end

# fd
if command -q fdfind
    set -gx FZF_DEFAULT_COMMAND "fdfind --type file --color=always"
else if command -q fd
    set -gx FZF_DEFAULT_COMMAND "fd --type file --color=always"
end

# fzf
if command -q fzf
    set -gx FZF_DEFAULT_OPTS "\
        --height ~40% --reverse --inline-info --ansi \
        --highlight-line \
        --info=inline-right \
        --layout=reverse \
        --border=none \
        --color=bg+:#1E222A \
        --color=bg:#1A1D23 \
        --color=border:#3A3E47 \
        --color=fg:#ADB0BB \
        --color=gutter:#1A1D23 \
        --color=header:#50A4E9 \
        --color=hl+:#5EB7FF \
        --color=hl:#5EB7FF \
        --color=info:#3A3E47 \
        --color=marker:#5EB7FF \
        --color=pointer:#5EB7FF \
        --color=prompt:#5EB7FF \
        --color=query:#ADB0BB:regular \
        --color=scrollbar:#3A3E47 \
        --color=separator:#3A3E47 \
        --color=spinner:#5EB7FF"
end

# kubert
if command -q kubert
  alias kctx 'kubert ctx'
  alias kns 'kubert ns'
end

# vi/vim/nvim
if command -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    alias vi nvim
    alias vim nvim
else if command -q vim
    set -gx EDITOR vim
    set -gx VISUAL vim
    alias vi vim
else
    set -gx EDITOR vi
    set -gx VISUAL vi
end

# fish plugins via fisher
#
if not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher install jorgebucaran/fisher
    fisher update
end

# things-that-hook-into-shell
#
if command -q atuin
    atuin init fish --disable-up-arrow | source
end

if command -q mise
    mise activate fish | source
end

if command -q starship
    starship init fish | source
end

if command -q zoxide
    zoxide init fish | source
end
