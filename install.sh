#/bin/bash

dir=~/.dotfiles
bdir=~/.dotfiles_old
files="bashrc bash_profile blocked_sites vimrc vim tmux.conf"

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


echo "Linking to OS specific extension file"

if [ "$(uname -s)" == "Darwin" ]; then
    ln -s $dir/mac/bash_ext ~/.bash_ext
elif [ "$(uname -s)" == "Linux" ]; then
    ln -s $dir/linux/bash_ext ~/.bash_ext
fi

