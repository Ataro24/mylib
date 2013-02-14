install:
	ln -i -s $(shell pwd)/X11/Xresources $(HOME)/.Xresources
	ln -i -s $(shell pwd)/X11/Xmodmap $(HOME)/.Xmodmap
	ln -i -s $(shell pwd)/emacs/emacs.el $(HOME)/.emacs
	ln -i -s $(shell pwd)/etc/vimperatorrc $(HOME)/.vimperatorrc
	ln -i -s $(shell pwd)/etc/vimperator $(HOME)/.vimperator
	ln -i -s $(shell pwd)/shell/bash_profile.sh $(HOME)/.bash_profile
	ln -i -s $(shell pwd)/shell/bashrc.sh $(HOME)/.bashrc
	ln -i -s $(shell pwd)/shell/zshrc.sh $(HOME)/.zshrc

clean:
	rm -f $(shell find $(shell pwd) -name '*~')
