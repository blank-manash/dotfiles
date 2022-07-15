#!/bin/bash

startup_prompt() {
  sudo apt-get update -y && sudo apt-get upgrade -y
  sudo apt install figlet git make cmake lolcat -y
  printf "\n==============================================================================================================\n"
  /usr/bin/figlet "BlankOS" | /usr/games/lolcat
  printf "\n==============================================================================================================\n"
}

startup() {
  printf "\n=========================================\n"
  echo "Welcome to BlankOS, This installtion script has been tested on Ubuntu 20.04, and is primarily developed for it."
  echo "You'd need a working installation of python3 (3.8.10), which comes by default in this distribution."
  echo "BE WARNED: There exists no uninstalltion script for this software and it comes with NO WARRANTY, proceed with caution."
  printf "\n=========================================\n"

  while true; do
    read -rp "Do you wish to install this program? (y/n) " yn
      case $yn in
          [Yy]* ) startup_prompt; break;;
          [Nn]* ) exit;;
          * ) echo "Please answer yes or no.";;
      esac
  done
}

startup
## Config files
create_directories() {
  mkdir -p ~/.config/i3
  mkdir -p ~/.config/nvim
  mkdir -p ~/.vim
  mkdir -p ~/.local/bin
  mkdir -p ~/.local/lib
  mkdir -p ~/code
  mkdir -p ~/.emacs.d
  mkdir -p ~/.fonts/Dank\ Mono/
  export PATH="$PATH:$HOME/.local/bin"
}

sudo apt install vifm neomutt cmus fonts-font-awesome curl jq ripgrep fd-find -y

install_fonts() {
  echo "Installing Fonts..."
  DANK_MONO_REGULAR="https://raw.githubusercontent.com/blank-manash/dotfiles/master/Downloads/Dank%20Mono/Dank%20Mono%20Regular%20%5BTheFontsMaster.com%5D.otf"
  DANK_MONO_ITALIC="https://raw.githubusercontent.com/blank-manash/dotfiles/master/Downloads/Dank%20Mono/Dank%20Mono%20Italic%20%5BTheFontsMaster.com%5D.otf"
  install_raw_file "$DANK_MONO_ITALIC" "$HOME/.fonts/truetype/Dank\ Mono\ Italic.otf"
  install_raw_file "$DANK_MONO_REGULAR" "$HOME/.fonts/truetype/Dank\ Mono\ Regular.otf"
}


## Install Rust and Cargo
rust_packages() {
  curl https://sh.rustup.rs -sSf | sh
  cargo install exa
  cargo install zoxide --locked
}


install_fzf() {
  echo ""
  echo "Installing FZF..."
  echo ""
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
}

install_neovim() {
  sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y
  cd ~/code || echo "$HOME/code Doesn't Exists" && exit
  git clone https://github.com/neovim/neovim
  cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd ~ || echo "Installation of Neovim Successful"
}

install_neovide() {
  sudo apt install -y curl gnupg ca-certificates git gcc-multilib g++-multilib cmake libssl-dev pkg-config libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev
  cd ~/code && git clone "https://github.com/neovide/neovide"
  cd neovide && cargo build release
  cp ./target/release/neovide ~/.local/bin/
  cd ~ && echo "Installation of Neovide Successful"
}

install_fuck() {
  sudo apt update -y
  sudo apt install -y python3-dev python3-pip python3-setuptools
  pip3 install thefuck --user
}

install_node() {
  printf "\nInstalling n: Version Manager with nodejs....\n"
  cd ~/code || exit
  curl -L https://raw.githubusercontent.com/tj/n/master/bin/n -o n
  bash n lts
  npm install -g n
  cd "$HOME" || exit
}

install_vs_code() {
  sudo apt install software-properties-common apt-transport-https wget -y
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
  sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
  sudo apt install code -y
}


pip_packages() {
  pip3 install youtube-dl
  pip3 install tldr
  sudo pip3 install i3-workspace-names-daemon
}

## Github Files
install_raw_file() {
  printf "\nInstalling File %s....\n" "$2"
  rm -rf "$2"
  curl -fsSL "$1" --create-dirs --output "$2"
}

install_emacs() {
  printf "\nInstalling Emacs28....\n"
  sudo apt remove --autoremove emacs emacs-common
  sudo add-apt-repository -y ppa:kelleyk/emacs
  sudo apt update -y
  sudo apt install -y emacs28
  EMACS_INIT="https://raw.githubusercontent.com/blank-manash/dotfiles/master/.emacs.d/init.el"
  DOTEMACS="https://raw.githubusercontent.com/blank-manash/dotfiles/master/.emacs.d/dotemacs.org"
  install_raw_file "$EMACS_INIT" "$HOME/.emacs.d/init.el"
  install_raw_file "$DOTEMACS" "$HOME/.emacs.d/dotemacs.org"
  emacs --daemon
}

install_github_files() {
  VIM_TERMINAL_SETUP_URL="https://raw.githubusercontent.com/blank-manash/dotfiles/master/.vim/terminal-setup.vim"
  VIM_TERMINAL_SETUP_LOC="$HOME/.vim/terminal-setup.vim"

  MY_BASHRC="https://raw.githubusercontent.com/blank-manash/dotfiles/master/.bashrc"
  MY_VIMRC="https://raw.githubusercontent.com/blank-manash/dotfiles/master/.vimrc"
  MY_NEOVIMRC="https://raw.githubusercontent.com/blank-manash/dotfiles/master/.config/nvim/init.lua"

  NVIM_COC_SETUP="https://raw.githubusercontent.com/blank-manash/dotfiles/master/.config/nvim/coc-settings.json"

  install_raw_file "$VIM_TERMINAL_SETUP_URL" "$VIM_TERMINAL_SETUP_LOC"
  install_raw_file "$MY_BASHRC" "$HOME/.bashrc"
  install_raw_file "$MY_VIMRC" "$HOME/.vimrc"
  install_raw_file "$MY_NEOVIMRC" "$HOME/.config/nvim/init.lua"
  install_raw_file "$NVIM_COC_SETUP" "$HOME/.config/nvim/coc-settings.json"
}

install_cava() {
  sudo apt install libfftw3-dev libasound2-dev libncursesw5-dev libpulse-dev libtool automake libiniparser-dev libsdl2-2.0-0 libsdl2-dev
  cd "$HOME/code" && git clone https://github.com/karlstav/cava.git
  cd cava && ./autogen.sh && ./configure.sh
  make
  make install
  cd "$HOME" && echo "Installation of Cava Complete!"
  CAVA_CONFIG="https://raw.githubusercontent.com/blank-manash/dotfiles/master/.config/cava/config"
  install_raw_file "$CAVA_CONFIG" "$HOME/.config/cava/config"
}

install_i3Blocks() {
  cd "$HOME/code" && git clone https://github.com/vivien/i3blocks
  cd i3blocks && ./autogen.sh && ./configure
  sudo make
  sudo make install
  I3_BLOCKS="https://raw.githubusercontent.com/blank-manash/dotfiles/master/.config/i3blocks/config"
  install_raw_file "$I3_BLOCKS" "$HOME/.config/i3blocks/config"
}

install_i3() {
  sudo add-apt-repository -y ppa:regolith-linux/release
  sudo apt update
  sudo apt install -y i3-gaps i3blocks
  APP_ICONS_URL='https://raw.githubusercontent.com/blank-manash/dotfiles/master/.config/i3/app-icons.json'
  I3_CONFIG="https://raw.githubusercontent.com/blank-manash/dotfiles/master/.config/i3/config"
  I3_STATUS="https://raw.githubusercontent.com/blank-manash/dotfiles/master/.config/i3status/config"
  install_raw_file "$APP_ICONS_URL" "$HOME/.config/i3/app-icons.json"
  install_raw_file "$I3_CONFIG" "$HOME/.config/i3/config"
  install_raw_file "$I3_STATUS" "$HOME/.config/i3status/config"
  install_i3Blocks
}

install_omb() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
}

install_Vifm() {
  cd "$HOME/code" && git clone https://github.com/cirala/vifm_devicons.git
  VIFMRC="https://raw.githubusercontent.com/blank-manash/dotfiles/master/.config/vifm/vifmrc"
  VIFM_COLOR="https://raw.githubusercontent.com/blank-manash/dotfiles/master/.config/vifm/colors/gruvbox.vifm"
  install_raw_file "$VIFMRC" "$HOME/.config/vifm/vifmrc"
  install_raw_file "$VIFM_COLOR" "$HOME/.config/vifm/colors/gruvbox.vifm"
}

create_directories
install_i3
install_emacs
install_fonts
install_fzf
install_neovim
install_Vifm
install_fuck
install_node
install_vs_code
install_cava
install_omb
install_github_files

pip_packages
rust_packages
