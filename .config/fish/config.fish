# Path configuration
set -U fish_user_paths ~/.local/bin ~/.cargo/bin /opt/homebrew/bin ~/Library/Python/3.8/bin \
    ~/.yarn/bin ~/.config/yarn/global/node_modules/.bin ~/go/bin /Users/manash.baul/.rd/bin $fish_user_paths


# FZF configuration
set -x FZF_DEFAULT_COMMAND "fd --hidden --ignore .git -l -g ''"
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_ALT_C_COMMAND "fd . $HOME"

# Environment variables
set -x VISUAL nvim
set -x EDITOR nvim

# Load Zoxide
zoxide init fish | source

# Load Starship prompt
eval (starship init fish)

# Rancher Desktop PATH
set -x PATH $PATH:/Users/manash.baul/.rd/bin

# Functions
function config-push
    config add $argv
    config commit -m "Updated $argv"
    config push
end

function mkcd
    mkdir $argv[1]; and cd $argv[1]
end


alias ff 'fd $argv[1] . | fzf | xargs -r nvim'
alias find 'fd'
alias grep 'rg'
alias bashcon 'nvim ~/.bashrc'
alias vimcon 'nvim ~/.vimrc'
alias fishcon 'nvim ~/.config/fish/config.fish'
alias e 'exit'
alias ls 'eza --icons'
alias l 'eza --icons -l'
alias cd 'z'
alias ncon 'nvim ~/.config/nvim/init.lua'
alias bi 'brew install'
alias g 'gitui'
alias t 'tmux'
alias ms 'make restart'
alias mt 'make test'
alias mr 'make run'
alias me 'nvim gtest.cpp'
alias mc 'cat gtest.cpp | pbcopy'
alias ed 'nvim ~/.scribe'
