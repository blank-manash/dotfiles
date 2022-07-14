#!/bin/bash
# File              : .bashrc
# Author            : Manash Baul <mximpaid@gmail.com>
# Date              : 30.04.2022
# Last Modified Date: 30.04.2022 # Last Modified By  : Manash Baul <mximpaid@gmail.com> Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac
bind '"jk":vi-movement-mode'
# Path to your oh-my-bash installation.
export OSH=/home/manash/.oh-my-bash
export PATH=~/.local/bin:$PATH
export PATH=~/.cargo/bin:$PATH
export LC_ALL=en_US.UTF-8
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="font"
# (cat ~/.cache/wal/sequences &)
OMB_USE_SUDO=true
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: 
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source "$OSH/oh-my-bash.sh"

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='nvim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"


## Dotfiles Manager

alias config="/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME"
config-push() {
    config add "$@"
    config commit -m "Updated $@"
    config push
}


export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
# Functions


open() { xdg-open "$1"; }
mkcd() { mkdir "$1" && cd "$1"; }

send-mail() {
  pushd "$HOME/Projects/MailCrustTarget";
  java -jar -Dsend=gamakshi@iitk.ac.in run.jar;
  popd;
}

eval "$(thefuck --alias)"
alias find="fdfind"
alias rmconnect="ssh -X manash@csews2.cse.iitk.ac.in"
alias i3con="nvim ~/.config/i3/config"
alias bashcon="nvim ~/.bashrc"
alias vimcon="nvim ~/.vimrc"
alias e="exit"
alias serve="python -m http.server 8080"
alias ls="exa --icons"
alias cd="z"
alias bat="batcat"
alias lim="light -S 100"
alias nm="neomutt"
alias em="pkill emacs || emacs --daemon"
alias emc="emacsclient -c"
alias ncon="nvim ~/.config/nvim/init.lua"

export FZF_DEFAULT_COMMAND="fdfind . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind . $HOME"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export VISUAL=nvim
export RMCC=manash@csews2.cse.iitk.ac.in

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
eval "$(zoxide init bash)"
eval "$(~/code/exa/completions/exa.bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

