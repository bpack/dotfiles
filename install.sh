#/bin/bash

dir=~/.dotfiles
bdir=~/.dotfiles_old2
files="bashrc bash_profile vimrc vim tmux.conf"

echo "Creating $bdir to back up existing dotfiles in $HOME"
mkdir -p $bdir

cd $dir

for file in $files; do
    if [ ! -L ~/.$file ]; then
        echo "Moving .$file from $HOME to $bdir"
        mv ~/.$file $bdir
        echo "Creating symlink to $file"
        ln -s $dir/$file ~/.$file
        echo 
    fi
done

