if status is-interactive
    # Commands to run in interactive sessions can go here
end

/opt/homebrew/bin/starship init fish | source

function fish_greeting
    echo "Current Date and Time: "(date "+%Y-%m-%d %H:%M:%S")
    echo "Kernel: "(uname -s)" "(uname -r)
end

set -x PATH /usr/local/sbin /usr/local/bin /System/Cryptexes/App/usr/bin /usr/bin /bin /usr/sbin /sbin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin /opt/homebrew/bin Users/yaroslavaugustus/Library/Python/3.9/bin /nix/var/nix/profiles/default/bin /usr/bin /bin /usr/sbin /sbin /usr/local/bin /Users/yaroslavaugustus/Library/Python/3.9/bin
