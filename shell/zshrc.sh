setopt prompt_subst
export PAGER="less"
export LESS="-imqMXR -x 8"
export LESSCHARSET=utf-8
export EDITOR="vi"

export TEXMFHOME=~/texmf	# dont set TEXINPUTS
export BIBCITEDIR=${TEXMFHOME}/bibtex/bib

export CVSROOT=/project/camp/cvs # solaris user
#export CVSROOT=camp:/project/camp/cvs  # for camp group
#export CVS_RSH=ssh

#
# util aliases
#
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -l -A'
alias du='du -hk'

alias grep='nocorrect grep --no-message --color'
alias cp='nocorrect cp -ir'
alias ln='nocorrect ln'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv -i'
alias setus='setxkbmap us'
alias gitgraph="git log --graph --all --color  --pretty='%x09%h %cn%x09%s %Cred%d%Creset'"

set -o noclobber		# no overwrite when redirect

# user file-creation mask
umask 022

#
# zsh gadgets
#
autoload -U compinit
compinit

# autoload predict-on
# predict-on

bindkey -e
bindkey ' ' magic-space

setopt always_last_prompt
setopt auto_cd
setopt auto_list
setopt auto_param_slash
setopt auto_pushd
setopt auto_remove_slash
setopt auto_resume
setopt bad_pattern
setopt beep
#setopt nobeep
setopt brace_ccl
setopt pushd_silent
setopt complete_aliases
setopt complete_in_word
setopt correct_all
setopt csh_null_glob
setopt extended_glob
unsetopt flow_control           # disable stop=^s and start=^q
setopt glob_dots
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt interactive_comments
setopt list_ambiguous
setopt list_types
setopt path_dirs
setopt pushd_ignore_dups
setopt pushd_to_home
setopt short_loops
setopt sun_keyboard_hack
setopt rc_expand_param

limit -h coredumpsize 0


# git
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%b'
zstyle ':vcs_info:*' actionformats '%b|%a'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
case $OSTYPE in
linux-gnu*)
    case $HOST in
    flandre | kirisame)
	prompt_color=yellow
    ;;
    patchouli | fastener | kamineko)
	prompt_color=magenta
    ;;
    kuroneko)
	prompt_color=blue
    ;;
    shironeko)
	prompt_color=cyan
    ;;

    *)
	prompt_color=cyan
    ;;
    esac

    PROMPT="%n@%U%B%F{${prompt_color}}%m%f%b%u -%1(v|%F{green}[%1v]%f|)":%~/$'\n$ '
    export PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/ruby/bin
    # ls color
    alias ls='ls -F --color'
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

#
# terminal command overlap
#
export HISTCONTROL=ignoreboth


#
# zstyles
#
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#
# for command-line(C-w)
#
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#
# compdef
#
compdef _tex platex
compdef _dvi dvipdf
compdef _hosts rdesktop
zstyle ':completion:*:rdesktop:*' hosts andes onion basilic parsil aconcagua everest
zstyle ':completion:*:rdesktop:*' sort false

export LS_COLORS='di=01;34'

#
# rbenvがあれば有効化
#
if [ -e $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
