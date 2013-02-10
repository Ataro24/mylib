#
# environment variables
#
#export PS1="\u@\[\033[41;1;37m\]\h\[\033[0m\]:\w/\$ "
#export PS1="\[\033[1m\033[34m\h(\u:\w)\\$ \033[0m\]"
#export PS1="\[\033[44;1;31m\][\u@\h:\W]$"
export PAGER="less"
export LESS="-imqMXR -x 8"
# export LESSCOLOR=red
export EDITOR="vi"
#
export TEXMFHOME=~/texmf	# dont set TEXINPUTS
export BIBCITEDIR=${TEXMFHOME}/bibtex/bib
export CVSROOT=/project/camp/cvs  # for camp group
export CVS_RSH=ssh

#
# aliases
#

alias la='ls -A'
alias ll='ls -l'
alias du='du -hk'
alias Andes='rdesktop andes -f'
alias Andes1='rdesktop andes -g 1250x980'
alias Nemacs='/usr/bin/emacs-21.4 -nw'
#alias ls='ls -F"'
#alias cd='exit'
#alias emacs='exit'
#alias vi='exit'
#alias unalias='exit'
#alias less='exit'
#alias cat='tac'
#alias alias='exit'


set -o noclobber		# no overwrite when redirect

# user file-creation mask
umask 022
ulimit -c 0

#
# PATH
#
case $OSTYPE in
linux-gnu*)
	export PS1="\u@\[\033[44;1;37m\]\h\[\033[0m\]:\w/\$ "
    export PATH=/bin:/usr/bin:/usr/X11R6/bin:/usr/local/bin:/usr/lib:/usr/lib64
    echo -n '[31m'
    /usr/bin/quota -q
    echo -n '[00m'
    alias ls='ls -F --color=auto'
    ;;
solaris*)
	export PS1="\u@\[\033[37;45;1m\]\h\[\033[0m\]:\w/\$ "
    export LANG='ja'
    export MANPATH=/usr/man:/opt/local/man:/usr/sfw/man:/opt/csw/man:/opt/SUNWspro/man:/usr/openwin/man:/usr/dt/man:/usr/X11/man
    export PATH=/opt/local/bin:/usr/bin:/usr/sfw/bin:/opt/csw/bin:/usr/ccs/bin:/opt/SUNWspro/bin:/usr/openwin/bin:/usr/dt/bin:/usr/X11/bin:/project/camp/bin:/usr/bin
    stty erase ^h
    stty intr  ^c
    stty susp  ^z
    echo -n '[31m'
    /usr/sbin/quota
    echo -n '[00m'
    alias ls='gls -F --color=auto'
    ;;
esac

    ### ptetex
    export PATH=$PATH:/usr/local/teTeX/bin
    export MANPATH=$MANPATH:/usr/local/teTeX/man

    export LS_COLORS='di=01;34;40'
