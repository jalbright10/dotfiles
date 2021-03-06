#!/bin/bash
############################
# .install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
#
# Adapted from Michael Smalley's dotfiles
# http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
# https://github.com/michaeljsmalley/dotfiles
############################

########## Variables
dir=~/dotfiles           # dotfiles directory
olddir=~/dotfiles_old    # old dotfiles backup directory
files="vimrc zshrc gitconfig"      # list of files/folders to symlink in homedir
##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo -e "done\n"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    if [ -L "$HOME/.$file" ]    # file is a symbolic link
    then
        echo "Deleting existing symbolic link .$file from home directory."
        rm ~/.$file
    elif [ -e "$HOME/.$file" ]  # file is a normal dotfile
    then
        echo "Moving .$file from ~ to $olddir"
        mv ~/.$file ~/dotfiles_old/
    fi

    echo -e "Creating symlink to $file in home directory.\n"
    ln -s $dir/$file ~/.$file
done

echo "Finished setting up dotfiles."
