# general settings for interactive shells
#
status is-interactive || exit 0

# variables
#
set -g fish_greeting
set -g fish_key_bindings fish_vi_key_bindings

# abbreviations
#
abbr --add cp 'cp -i'
abbr --add mv 'mv -i'
abbr --add rm 'rm -i'
abbr --add grep 'grep -E'
abbr --add la 'ls -A'
abbr --add ll 'ls -lh'
abbr --add lla 'ls -lhA'
abbr --add k kubectl
abbr --add refish 'exec fish'

abbr --add L --position anywhere --set-cursor "% | less"

# aliases
#
alias apt-list-backports 'aptitude search -t (lsb_release -sc)-backports -F "%p %v -> %V" "~U ~Abackports"'
alias beets-container 'podman compose -f ~/.local/bin/beets/compose.yaml pull --policy=always && podman compose -f ~/.local/bin/beets/compose.yaml run --rm beets'
