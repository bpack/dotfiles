## dotfiles


`git clone https://github.com/bpack/dotfiles .dotfiles`
`git submodule init`
`git submodule update`

Run `install.sh` to backup existing files and symlink the files here to their dot-named counterparts.

To get vim working properly you'll need to issue a `:PluginInstall` command for Vundle to install plugins.
