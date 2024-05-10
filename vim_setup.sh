#!/bin/bash
username="$USER" #Getting the username now as it looks cleaner to grab now rather than later.
defualtSleep=`sleep 5` #Setting default sleep so I don't have to keep typing in sleep 5

echo "Hello this is a simple script that will setup vim to my liking." #This includes my vim color scheme, laungauge server for bash, status bar, nerdtree, and numbered lines.
echo -e "This script will install vim, curl, git, and vim-plug. As all are necessary for the setup. \n"
# Future Implementation echo "I will also be installing a font called Space Mono." #This is the font I use for my terminal, and vim.
sleep 11
echo  "Also between statements stating something is installing, is a 5 second sleep to allow you to CTRL+C to prevent install."
echo -e "This is here to prevent uncompleted installs. Which is a pain, to deal with! \n"
sleep 12


if test -f /home/$username/vimrc.vimrc; then
    echo "Necessary Dependency is already downloaded. "
    echo -n "I will now check for vim and curl, and install them if their not installed."
    vimtxtDownloadStatus=1 #Setting the downloaded status to 1, as it is downloaded.
    $defualtSleep
else
    echo -e "Necesary dependency is not installed (vimrc). 
    I will install vimrc in a little bit, but first I need to check if vim and curl is installed. \n" 
    vimtxtDownloadStatus=0 #setting the downloaded status to 0, as it is not downloaded.
    $defualtSleep
fi

# clear
echo -e "\n"
echo -n "Now checking for vim! "
if dpkg -l | grep -q -i "vim"; then #Checking for vim
    echo -e "Vim is already installed! \n"
else
    echo -e "Vim is not installed, installing vim now! \n"
    $defualtSleep
    sudo apt install vim
    echo -e "Vim is now installed! \n"
fi

$defualtSleep

echo -n "Now checking for curl! "
if dpkg -l | grep -q -i "curl"; then #Checking for curl
    echo -e "Curl is already installed! \n"
else
    echo -e "Curl is not installed, installing curl now! \n"
    $defualtSleep
    sudo apt install curl
    echo -e "Curl is now installed! \n"
fi
 
 $defualtSleep 

echo -n "Now checking for git! "
if dpkg -l | grep -q -i "git"; then #Checking for git
    echo -e "Git is already installed! \n"
else
    echo -e "Git is not installed, installing git now! \n"
    $defualtSleep
    sudo apt install git-all -y > /dev/null 
    echo -e "Git is now installed! \n"
fi

$defualtSleep

echo -e "Now installing vim-plug (It will be installed in the recommended directory, look on vim-plug README for more info) \n"
$defualtSleep
curl -fLo /home/$username/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null 2>&1 #Pulling dependencies for vimrc config file

if [ $vimtxtDownloadStatus -eq '0' ]; then 
    echo "Now downloading vimrc config file" 
    $defualtSleep
curl -fLo /home/$username/vimrc.vimrc https://gist.githubusercontent.com/LeopardDrager/b657cb0d2c0f78d2f4c9ab5ec316133a/raw
fi


    

echo -e "Now you are ready to actually install the plugins! \n"
echo "First I'm going to put all the plugins and config options in your .vimrc file!"
sleep 6


cat /home/$username/vimrc.vimrc > /home/$username/.vimrc #Putting everything from vimrc.vimrc into the .vimrc file
vim +'PlugInstall --sync' +qa #Installing all of the plugins via the terminal, rather than the vim editor.
echo -e "All plugins are now installed! \n"
echo "Now cleaning up"
rm /home/$username/vimrc.vimrc #Removing the vimrc.vimrc file as it is no longer needed.
echo "All done now. Goodbye!"
sleep 3
clear
exit 0

