#!/bin/bash
MYLIB=$(pwd)

echo "install all setting files start..."
## X11
ln -i -s $MYLIB/X11/Xresources $HOME/.Xresources
ln -i -s $MYLIB/X11/Xmodmap $HOME/.Xmodmap
## shells
ln -i -s $MYLIB/shell/bash_profile.sh $HOME/.bash_profile
ln -i -s $MYLIB/shell/bashrc.sh $HOME/.bashrc
ln -i -s $MYLIB/shell/zshrc.sh $HOME/.zshrc
## emacs
ln -i -s $MYLIB/emacs/emacs.el $HOME/.emacs
## vi
ln -i -s $MYLIB/vim/vimrc $HOME/.vimrc
## screen, tmux
ln -i -s $MYLIB/screen/screenrc $HOME/.screenrc
ln -i -s $MYLIB/screen/tmux.conf $HOME/.tmux.conf
## vimperator
if [ -e $HOME/.vimperator ]; then
    echo "$HOME/.vimperator already exist. old dir is moved"
    mv $HOME/.vimperator $HOME/.vimperator.back
fi
ln -i -s $MYLIB/etc/vimperator $HOME/.vimperator
ln -i -s $MYLIB/etc/vimperatorrc $HOME/.vimperatorrc

echo "install finished!!"
