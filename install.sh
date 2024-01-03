#!/bin/bash


# installing tools for OS
echo "Installing tools for OS"
bash installTools.sh

# installing fonts
echo "Installing fonts"
bash installFont.sh


# config zshrc

echo "Config zshrc"
cp zshrc ~/.zshrc

# config tmux
echo "Config tmux"
if [ ! -d ~/.config/tmux ]; then
    mkdir -p ~/.config/tmux
else
    echo "tmux folder exists"
    echo "removing tmux folder and create new one"
    mv ~/.config/tmux ~/.config/tmux_old
    mkdir -p ~/.config/tmux
fi
cp tmux.conf ~/.config/tmux/.tmux.conf

# config nvim
echo "Config nvim"
if [ ! -d ~/.config/nvim ]; then
    mkdir -p ~/.config/nvim
else
    echo "nvim folder exists"
    echo "removing nvim folder and create new one"
    mv ~/.config/nvim ~/.config/nvim_old
    mkdir -p ~/.config/nvim
fi
cp -r nvim-config/* ~/.config/nvim/

# config git
echo "Config git"
cp gitconfig ~/.gitconfig

# config alacritty
echo "Config alacritty"
if [ ! -d ~/.config/alacritty ]; then
    mkdir -p ~/.config/alacritty
else
    echo "alacritty folder exists"
    echo "removing alacritty folder and create new one"
    mv ~/.config/alacritty ~/.config/alacritty_old
    mkdir -p ~/.config/alacritty
fi
cp alacritty.yml ~/.config/alacritty/alacritty.yml

# config ranger
echo "Config ranger"
if [ ! -d ~/.config/ranger ]; then
    mkdir -p ~/.config/ranger
else
    echo "ranger folder exists"
    echo "removing ranger folder and create new one"
    mv ~/.config/ranger ~/.config/ranger_old
    mkdir -p ~/.config/ranger
fi
cp -r ranger/* ~/.config/ranger/


source ~/.zshrc
