# configuration for external utilities
#
status is-interactive || exit 0

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
    abbr --add kctx 'kubert ctx'
    abbr --add kns 'kubert ns'
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
