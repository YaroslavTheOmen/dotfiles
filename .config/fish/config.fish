set -Ux EDITOR nvim

set -x PATH ~/.local/bin ~/.cargo/bin ~/go/bin ~/.config/emacs/bin /Users/yaroslavaugustus/.foundry/bin ~/.npm-global/bin ~/.local/share/npm/bin /opt/homebrew/opt/python@3.13/bin /opt/homebrew/opt/llvm/bin /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin /usr/local/sbin /System/Cryptexes/App/usr/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin /usr/bin /bin /usr/sbin /sbin /Applications/Obsidian.app/Contents/MacOS

function b
    bash -c "$argv"
end

if status is-interactive
    /opt/homebrew/bin/starship init fish | source

    function fish_greeting
        echo "Current Date and Time: "(date "+%Y-%m-%d %H:%M:%S")
        echo "Kernel: "(uname -s)" "(uname -r)
    end

    if test -f /Users/yaroslavaugustus/miniconda3/bin/conda
        eval /Users/yaroslavaugustus/miniconda3/bin/conda "shell.fish" "hook" $argv | source
    else
        if test -f "/Users/yaroslavaugustus/miniconda3/etc/fish/conf.d/conda.fish"
            . "/Users/yaroslavaugustus/miniconda3/etc/fish/conf.d/conda.fish"
        else
            set -gx PATH "/Users/yaroslavaugustus/miniconda3/bin" $PATH
        end
    end
end

function use_system_python
    if type -q conda
        conda deactivate 2>/dev/null
    end

    set -e PYTHONHOME
    set -e PYTHONPATH
    set -e CONDA_PREFIX
    set -e CONDA_DEFAULT_ENV
    set -e CONDA_SHLVL
    set -e CMAKE_PREFIX_PATH
    set -e AMENT_PREFIX_PATH
    set -e COLCON_PREFIX_PATH

    set -gx PATH (string match -v -r '^/Users/yaroslavaugustus/miniconda3' $PATH)
end


# set -Ux EDITOR nvim
#
# set -x PATH ~/.local/bin ~/.cargo/bin ~/go/bin ~/.npm-global/bin ~/.local/share/npm/bin ~/.config/yarn/global/node_modules/.bin ~/.config/emacs/bin /usr/local/go/bin /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin /snap/bin /usr/games /usr/local/games ~/elixir-ls/release ~/.asdf/shims /usr/local/cuda/bin /usr/local/cuda/lib64 ~/.bun/bin /usr/local/bin/obsidian
#
# function b
#     bash -c "$argv"
# end
#
# if status is-interactive
#     /usr/local/bin/starship init fish | source
#
#     function fish_greeting
#         echo "Current Date and Time: "(date "+%Y-%m-%d %H:%M:%S")
#         echo "Kernel: "(uname -s)" "(uname -r)
#     end
#
#     if test -f "$HOME/miniconda3/bin/conda"
#         eval "$HOME/miniconda3/bin/conda" "shell.fish" "hook" $argv | source
#     else if test -f "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
#         . "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
#     else
#         set -gx PATH "$HOME/miniconda3/bin" $PATH
#     end
#
#     set -gx NVM_DIR $HOME/.nvm
#     if test -s $NVM_DIR/nvm.sh
#         function nvm
#             bass source $NVM_DIR/nvm.sh --no-use ';' nvm $argv
#         end
#         nvm use default >/dev/null 2>&1
#     end
# end
#
# function use_ros_jazzy
#     bass source /opt/ros/jazzy/setup.bash
#     bass source ~/IsaacSim-ros_workspaces/jazzy_ws/install/local_setup.bash
# end
#
# function use_isaac_ros_jazzy
#     bass source ~/IsaacSim-ros_workspaces/build_ws/jazzy/jazzy_ws/install/local_setup.bash
#     bass source ~/IsaacSim-ros_workspaces/build_ws/jazzy/isaac_sim_ros_ws/install/local_setup.bash
# end
#
# function use_system_python
#     if type -q conda
#         conda deactivate 2>/dev/null
#     end
#     set -gx PATH /usr/bin /bin /usr/sbin /sbin $PATH
# end
