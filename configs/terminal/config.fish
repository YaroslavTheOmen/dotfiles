if status is-interactive
    # Commands to run in interactive sessions can go here
end

# set your shell
/opt/homebrew/bin/starship init fish | source

function fish_greeting
    echo "Current Date and Time: "(date "+%Y-%m-%d %H:%M:%S")
    echo "Kernel: "(uname -s)" "(uname -r)
end
