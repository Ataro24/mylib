#
# environment variables
#
#export PS1="\u@\[\033[41;1;37m\]\h\[\033[0m\]:\w/\$ "
#export PS1="\[\033[1m\033[34m\h(\u:\w)\\$ \033[0m\]"
#export PS1="\[\033[44;1;31m\][\u@\h:\W]$"
export PAGER="less"
export LESS="-imqMXR -x 8"
export EDITOR="vi"


#
# aliases
#

alias la='ls -A'
alias ll='ls -lh'
alias du='du -hk'

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
	export PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/lib:/usr/lib64
	alias ls='ls -F --color=auto'
    ;;
esac
export LS_COLORS='di=01;34;40'
