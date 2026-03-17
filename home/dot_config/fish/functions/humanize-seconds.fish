function humanize-seconds
    set -l T $argv[1]
    set -l D (math -s0 "$T / 86400")
    set -l H (math -s0 "$T / 3600 % 24")
    set -l M (math -s0 "$T / 60 % 60")
    set -l S (math -s0 "$T % 60")

    set -l parts
    test $D -gt 0 && set -a parts "$D days"
    test $H -gt 0 && set -a parts "$H hours"
    test $M -gt 0 && set -a parts "$M minutes"
    set -a parts "$S seconds"

    if test (count $parts) -gt 1
        echo (string join ' ' $parts[1..-2]) and $parts[-1]
    else
        echo $parts[1]
    end
end
