# general settings
#
umask 027

# path
#
fish_add_path --path /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin ~/.local/bin

# locale
#
set -gx LANG en_IE.UTF-8
set -gx LC_COLLATE pl_PL.UTF-8
set -gx LC_CTYPE pl_PL.UTF-8
set -gx LC_MESSAGES C.UTF-8
set -gx TZ Europe/Dublin

# environment
#
set -gx CLAUDE_CODE_NO_FLICKER 1
set -gx EMAIL "yacoob@ftml.net"
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx LESS -iSRM
set -gx LIBPROC_HIDE_KERNEL 1
set -gx PIP_REQUIRE_VIRTUALENV true
set -gx SHELL $(which fish)
set -gx SSH_AUTH_SOCK ~/.1password/agent.sock
set -gx TMPDIR /tmp
