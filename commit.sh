#!/bin/bash

# Set the path to your folder
folder_path=$(pwd)

# Get the current date and time
current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

# Add all changes to the staging area
git add .

# Commit changes with a commit message including date and time
git commit -m "Auto commit on $current_datetime"

# Push changes if needed
# git push origin master  # Uncomment and modify based on your branch
git push --all

echo "Changes committed successfully."
