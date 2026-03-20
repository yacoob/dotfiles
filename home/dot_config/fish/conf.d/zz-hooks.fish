# hooks
#
status is-interactive || exit 0

# fzf.fish keybindings
if functions -q fzf_configure_bindings
    fzf_configure_bindings --processes=ctrl-alt-i
end

# atuin - will override ctrl-r bind
if command -q atuin
    atuin init fish --disable-up-arrow | source
end

# mise chdir hooks
if command -q mise
    mise activate fish | source
end

# prompt via starship
if command -q starship
    starship init fish | source
end

# zoxide chdir hooks
if command -q zoxide
    zoxide init fish --cmd cd | source
end

