#!/bin/bash

# Function to create backup and move folder
backup_and_move_folder() {
    local folder_path=$1
    if [ -d "$folder_path" ]; then
        echo "$folder_path folder exists"
        echo "Backing up $folder_path to ${folder_path}_old"
        mv "$folder_path" "${folder_path}_old"
    fi
}

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
backup_and_move_folder "~/.config/tmux"
rm -rf ~/tmux
cp -r ./tmux ~/.config

# config nvim
echo "Config nvim"
backup_and_move_folder "~/.config/nvim"
cp -r ./nvim ~/.config

# config git
echo "Config git"
cp gitconfig ~/.gitconfig

# config alacritty
echo "Config alacritty"
backup_and_move_folder "~/.config/alacritty"
cp -r ./alacritty ~/.config

# config ranger
echo "Config ranger"
backup_and_move_folder "~/.config/ranger"
cp -r ./ranger ~/.config

echo "Configuration setup complete."
