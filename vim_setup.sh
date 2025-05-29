#!/bin/bash

defaultSleep="sleep 5"

echo "Hello, this script sets up Vim with your preferred configuration."
echo -e "It installs vim, curl, git, and vim-plug.\n"
sleep 5

echo "There will be short delays between major steps to let you Ctrl+C if needed."
sleep 5

VIMRC_URL="https://gist.githubusercontent.com/LeopardDrager/b657cb0d2c0f78d2f4c9ab5ec316133a/raw"
TEMP_VIMRC="$HOME/vimrc_temp.vimrc"

# Check for temporary vimrc file
if [ -f "$TEMP_VIMRC" ]; then
    echo "Temporary vimrc file already exists."
    vimrcDownloaded=true
else
    echo "Temporary vimrc file not found."
    vimrcDownloaded=false
fi
$defaultSleep

echo -e "\nChecking for Vim..."
if ! command -v vim &> /dev/null; then
    echo "Installing Vim..."
    $defaultSleep
    sudo apt install vim -y
else
    echo "Vim is already installed."
fi

$defaultSleep

echo -e "\nChecking for curl..."
if ! command -v curl &> /dev/null; then
    echo "Installing curl..."
    $defaultSleep
    sudo apt install curl -y
else
    echo "curl is already installed."
fi

$defaultSleep

echo -e "\nChecking for Git..."
if ! command -v git &> /dev/null; then
    echo "Installing Git..."
    $defaultSleep
    sudo apt install git -y
else
    echo "Git is already installed."
fi

$defaultSleep

# Install vim-plug
echo -e "\nInstalling vim-plug..."
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

$defaultSleep

# Download vimrc config if needed
if [ "$vimrcDownloaded" = false ]; then
    echo -e "\nDownloading vimrc configuration..."
    curl -fLo "$TEMP_VIMRC" "$VIMRC_URL"
fi

$defaultSleep

# Apply vimrc
echo -e "\nApplying vimrc..."
cat "$TEMP_VIMRC" > "$HOME/.vimrc"

# Install plugins
vim +'PlugInstall --sync' +qa

echo -e "\nAll plugins installed. Cleaning up..."
rm -f "$TEMP_VIMRC"

echo "Setup complete. Enjoy your Vim!"
sleep 2
clear
exit 0
