#!/bin/bash

# Check if OS is Linux or Mac
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}"
esac

function install_linux_tools() {
    echo "Installing tools for Linux"
    sudo apt-get update
    sudo apt-get install -y git curl unzip wget nvim zsh tmux python3-pip nodejs npm openjdk-8-jdk openjdk-17-jdk alacritty fortune surf xcowsay ranger
}

function install_mac_tools() {
    echo "Installing tools for Mac"
    install_brew
    brew update
    brew install git curl wget nvim unzip zsh alacritty tmux python node npm openjdk@8 openjdk@17 ranger
}

function install_brew() {
    echo "Installing Brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function install_tldr() {
    echo "Installing tldr"
    npm install -g tldr
}

function install_oh_my_zsh() {
    echo "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function install_nvm() {
    echo "Installing NVM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
}


function install_packer() {
    echo "Installing Packer"
    if [ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
        echo "Installing packer"
        git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    fi
}

function install_tpm() {
    echo "Installing TPM"
    if [ ! -d ~/.tmux/plugins/tpm ]; then
        echo "Installing tpm"
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
}

start=`date +%s.%N`

if [ "$machine" == "Linux" ]; then
    install_linux_tools
    echo "Linux"
elif [ "$machine" == "Mac" ]; then
    install_mac_tools
    echo "Mac"
fi

# Common steps for both Linux and Mac
install_nvm
install_oh_my_zsh

# Install tldr
install_tldr

# Install vim packer
install_packer


# install tpm for tmux
install_tpm


end=`date +%s.%N`

runtime=$( echo "$end - $start" | bc -l )
echo "Runtime was $runtime seconds"