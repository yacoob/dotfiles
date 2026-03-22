# homebrew
#
# always modify PATH etc.
if not set -q HOMEBREW_PREFIX
    if test -x /home/linuxbrew/.linuxbrew/bin/brew
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    end
end

status is-interactive || exit 0

# ...but only add completions in an interactive shell
if set -q HOMEBREW_PREFIX
    for dir in $HOMEBREW_PREFIX/share/fish/{completions,vendor_completions.d}
        if test -d $dir
            set -p fish_complete_path $dir
        end
    end
end
