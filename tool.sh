#!/usr/bin/env bash

# Check if OS is Linux or Mac
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine="UNKNOWN:${unameOut}"
esac

function installing_linux_tools() {
    echo "Installing tools for Linux"
    sudo apt-get update
    sudo apt-get install -y git curl wget nvim zsh tmux python3-pip nodejs npm openjdk-8-jdk openjdk-17-jdk
}

function installing_mac_tools() {
    echo "Installing tools for Mac"
    installing_brew
    brew update
    brew install git curl wget nvim zsh tmux python node npm openjdk@8 openjdk@17
}

function installing_brew() {
    echo "Installing Brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function installing_oh_my_zsh() {
    echo "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function installing_nvm() {
    echo "Installing NVM"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
}

if [ "$machine" == "Linux" ]; then
    installing_linux_tools
    echo "Linux"
elif [ "$machine" == "Mac" ]; then
    installing_mac_tools
    echo "Mac"
fi

# Common steps for both Linux and Mac
installing_nvm
installing_oh_my_zsh

