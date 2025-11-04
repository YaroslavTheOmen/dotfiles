if status is-interactive
    # Commands to run in interactive sessions can go here
end

/opt/homebrew/bin/starship init fish | source

function fish_greeting
    echo "Current Date and Time: "(date "+%Y-%m-%d %H:%M:%S")
    echo "Kernel: "(uname -s)" "(uname -r)
end

set -Ux EDITOR nvim

set -x PATH /usr/local/sbin /usr/local/bin /System/Cryptexes/App/usr/bin /usr/bin /bin /usr/sbin /sbin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin /opt/homebrew/bin /usr/bin /bin /usr/sbin /sbin /usr/local/bin ~/miniconda3/bin /opt/homebrew/opt/python@3.13/bin /Users/yaroslavaugustus/.foundry/bin ~/.config/emacs/bin ~/go/bin ~/.local/bin /opt/homebrew/opt/llvm/ 

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/yaroslavaugustus/miniconda3/bin/conda
    eval /Users/yaroslavaugustus/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/yaroslavaugustus/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/yaroslavaugustus/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/yaroslavaugustus/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<


# if status is-interactive
#     # Commands to run in interactive sessions can go here
# end
#
# /usr/local/bin/starship init fish | source
#
# function fish_greeting
#     echo "Current Date and Time: "(date "+%Y-%m-%d %H:%M:%S")
#     echo "Kernel: "(uname -s)" "(uname -r)
# end
#
# set -Ux EDITOR nvim
#
# set -x PATH ~/.local/bin /home/yaroslavaugustus/miniconda3/bin /home/yaroslavaugustus/miniconda3/condabin /home/yaroslavaugustus/.cargo/bin /home/yaroslavaugustus/.local/bin /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games /usr/local/games /snap/bin ~/.local/npm/bin  ~/.config/emacs/bin /snap/bin /home/yaroslavaugustus/.local/bin
#
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# if test -f "$HOME/miniconda3/bin/conda"
#     eval "$HOME/miniconda3/bin/conda" "shell.fish" "hook" $argv | source
# else if test -f "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
#     . "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
# else
#     set -gx PATH "$HOME/miniconda3/bin" $PATH
# end
# # <<< conda initialize <<<
#
# bass source /opt/ros/jazzy/setup.bash
