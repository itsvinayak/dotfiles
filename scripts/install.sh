#!/bin/bash

# Function to create backup and move folder
backup_and_move_folder() {
    local folder_path=$1
    if [ -d "$folder_path" ]; then
        echo "$folder_path folder exists"
        echo "Backing up $folder_path to ${folder_path}_bak"
        if [ -d "${folder_path}_bak" ]; then
            rm -rf "${folder_path}_bak"
        fi
        mv "$folder_path" "${folder_path}_bak"
    fi
}

echo -e '\033[2J\033[u'

# prompt for if tools and fonts are installed
echo "Have you installed tools ? (y/n)"
read -r tools_installed

if [ "${tools_installed:l}" = "y" ]; then
    bash installTools.sh
    echo "Please restart your terminal to apply tool changes"
else
    echo "Skipping tools installation"
fi

echo "Have you installed fonts ? (y/n)"
read -r fonts_installed

if [ "${fonts_installed:l}" = "y" ]; then
    bash installFont.sh
    echo "Please restart your terminal to apply font changes"
else
    echo "Skipping fonts installation"
fi

echo "installing config files ..."

# config zshrc
echo "Config zshrc"
cp zsh ~/.config

# config tmux
echo "Config tmux"
backup_and_move_folder ~/.config/tmux
rm -rf ~/.tmux ~/.tmux.conf
cp -r ./tmux ~/.config

# config nvim
echo "Config nvim"
backup_and_move_folder ~/.config/nvim
cp -r ./nvim ~/.config

# config git
echo "Config git"
cp gitconfig ~/.gitconfig

# config alacritty
echo "Config alacritty"
backup_and_move_folder ~/.config/alacritty
cp -r ./alacritty ~/.config

# config ranger
echo "Config ranger"
backup_and_move_folder ~/.config/ranger
cp -r ./ranger ~/.config

echo "setting up Notes folder"
if [ ! -d ~/DevNotesAndCode ]; then
    git clone https://github.com/itsvinayak/DevNotesAndCode.git ~/DevNotesAndCode
else
    echo "Notes folder already exists"
    echo "Updating Notes folder"
    cd ~/DevNotesAndCode || exit
    git pull
    cd - || exit
fi
echo "Notes folder setup complete."

echo "Configuration setup complete."
