if status is-interactive
    # Commands to run in interactive sessions can go here
end

/opt/homebrew/bin/starship init fish | source

function fish_greeting
    echo "Current Date and Time: "(date "+%Y-%m-%d %H:%M:%S")
    echo "Kernel: "(uname -s)" "(uname -r)
end

function b
    bash -c "$argv"
end

set -Ux EDITOR nvim

set -x PATH ~/.local/bin ~/.cargo/bin ~/go/bin ~/.config/emacs/bin /Users/yaroslavaugustus/.foundry/bin ~/.npm-global/bin ~/.local/share/npm/bin /opt/homebrew/opt/python@3.13/bin /opt/homebrew/opt/llvm/bin /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin /usr/local/sbin /System/Cryptexes/App/usr/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin /usr/bin /bin /usr/sbin /sbin

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

# /usr/local/bin/starship init fish | source

# function fish_greeting
#     echo "Current Date and Time: "(date "+%Y-%m-%d %H:%M:%S")
#     echo "Kernel: "(uname -s)" "(uname -r)
# end

# function b
#     bash -c "$argv"
# end

# set -Ux EDITOR nvim

# set -x PATH ~/.local/bin ~/.cargo/bin ~/go/bin ~/.npm-global/bin ~/.local/share/npm/bin ~/.config/yarn/global/node_modules/.bin ~/.config/emacs/bin ~/.pyenv/shims ~/.pyenv/bin /usr/local/go/bin /home/yaroslavaugustus/miniconda3/condabin /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin /snap/bin /usr/games /usr/local/games ~/elixir-ls/release/ ~/.asdf/shims/ /usr/local/cuda/bin /usr/local/cuda/lib64 ~/.bun/bin

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

# bass source /opt/ros/jazzy/setup.bash
# bass source ~/.cargo/env

# set -gx NVM_DIR $HOME/.nvm

# if test -s $NVM_DIR/nvm.sh
#     bass source $NVM_DIR/nvm.sh ';' nvm use default
# end
