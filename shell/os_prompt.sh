#
# PATH
#
case $OSTYPE in
linux-gnu*)
    case $HOST in
    moco.matlab.nitech.ac.jp)
	    PROMPT="%n@"$'%{\e[$[44]m%}'"%m"$'\e[m'":%~/
$ "	
    ;;
    flandre)
	    PROMPT="%n@%U%B%F{yellow}%m%f%b%u":%~/$'\n$ '
    ;;
    patchouli)
	    PROMPT="%n@%U%B%F{magenta}%m%f%b%u":%~/$'\n$ '
    ;;

    *)
    PROMPT="%n@"$'%{\e[$[42]m%}'"%m"$'\e[m'":%~/
$ "
    ;;
    esac

    export PATH=/bin:/usr/bin:/usr/X11R6/bin:/usr/local/bin:/usr/local/ruby/bin:/usr/sbin
    echo -n '[31m'
    echo -n '[00m'
    
    # ls color
    alias ls='ls -F --color -G'
    ;;

solaris*)
#	PROMPT=$'%{\e[$[41]m%}'"%n@%m"$'\e[m'":%~/$ "
    PROMPT="%n@"$'%{\e[$[41]m%}'"$HOST"$'\e[m'":%~/
$ "
	
    export LANG='ja'
    export MANPATH=/usr/man:/opt/local/man:/usr/sfw/man:/opt/csw/man:/opt/SUNWspro/man:/usr/openwin/man:/usr/dt/man:/usr/X11/man
    export PATH=/opt/local/bin:/usr/bin:/usr/sbin:/usr/sfw/bin:/opt/csw/bin:/usr/ccs/bin:/opt/SUNWspro/bin:/usr/openwin/bin:/usr/dt/bin:/usr/X11/bin:/project/camp/bin:/project/camp/sim/proj-sap/bin
    noglob stty erase ^h
    noglob stty intr  ^c
    noglob stty susp  ^z
    echo -n '[31m'
    /usr/sbin/quota
    echo -n '[00m'

    # ls color
    case $HOST in
	sangria)
	    alias ls='ls -F'
	    ;;
	*)
	    alias ls='gls -F --color'
	    ;;
    esac
    #eval `dircolors ~/.dir_colors`
    #source ~/.lscolor
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    ;;

freebsd*)#FreeBSD用
#	PROMPT=$'%{\e[$[41]m%}'"%n@%m"$'\e[m'":%~/$ "
    PROMPT="%n@"$'%{\e[$[46]m%}'"%m"$'\e[m'":%~/
$ "	
	
    export LANG='ja'
#    export MANPATH=/usr/man:/opt/local/man:/usr/sfw/man:/opt/csw/man:/opt/SUNWspro/man:/usr/openwin/man:/usr/dt/man:/usr/X11/man
 #   export PATH=/opt/local/bin:/usr/bin:/usr/sbin:/usr/sfw/bin:/opt/csw/bin:/usr/ccs/bin:/opt/SUNWspro/bin:/usr/openwin/bin:/usr/dt/bin:/usr/X11/bin:/project/camp/bin:/project/camp/sim/proj-sap/bin

    export PATH=/bin:/usr/bin:/usr/X11R6/bin:/usr/local/bin:/usr/local/ruby/bin:/project/camp/sim/proj-sap/bin
    echo -n '[31m'

    echo -n '[00m'

    # ls color
#    alias ls='ls -F --color'
    alias ls='ls -FG'
    export LSCOLORS=ExGxxxxxCxxxxxxxxxxxxx
    #eval `dircolors ~/.dir_colors`
    #source ~/.lscolor
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    ;;
esac
