#!/bin/bash
MYLIB=$(pwd)
LNOPTS="-i"

for OPT in $*
do
    case $OPT in
        '-f' )
            unset LNOPTS
            LNOPTS="-f"
            ;;
    esac
    shift
done

echo "install all setting files start..."
echo "ln option is "$LNOPTS

## X11
ln $LNOPTS -s $MYLIB/X11/Xresources $HOME/.Xresources
ln $LNOPTS -s $MYLIB/X11/Xmodmap $HOME/.Xmodmap
## shells
ln $LNOPTS -s $MYLIB/shell/bash_profile.sh $HOME/.bash_profile
ln $LNOPTS -s $MYLIB/shell/bashrc.sh $HOME/.bashrc
ln $LNOPTS -s $MYLIB/shell/zshrc.sh $HOME/.zshrc
## emacs
ln $LNOPTS -s $MYLIB/emacs/emacs.el $HOME/.emacs
if [ ! -e $HOME/.emacsbacks ]; then
    echo "$HOME/.emacsbacks not found."
    mkdir $HOME/.emacsbacks
    echo "   -> mkdir $HOME/.emacsbacks"
fi
## vi
ln $LNOPTS -s $MYLIB/vim/vimrc $HOME/.vimrc
## screen, tmux
ln $LNOPTS -s $MYLIB/screen/screenrc $HOME/.screenrc
ln $LNOPTS -s $MYLIB/screen/tmux.conf $HOME/.tmux.conf
## vimperator
if [ -e $HOME/.vimperator ]; then
    echo "$HOME/.vimperator already exist. old dir is moved"
    mv $HOME/.vimperator $HOME/.vimperator.back
fi
ln $LNOPTS -s $MYLIB/etc/vimperator $HOME/.vimperator
ln $LNOPTS -s $MYLIB/etc/vimperatorrc $HOME/.vimperatorrc

echo "install finished!!"
