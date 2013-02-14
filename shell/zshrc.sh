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
# aliases
#

#alias ls='ls -F'
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -l -A'
alias du='du -hk'
#alias grep='grep --color'
#alias egrep='egrep --color'

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

    *)
    PROMPT="%n@"$'%{\e[$[42]m%}'"%m"$'\e[m'":%~/
$ "
    ;;
    esac

    export PATH=/bin:/usr/bin:/usr/X11R6/bin:/usr/local/bin:/usr/local/ruby/bin:/project/camp/sim/proj-sap/bin
    echo -n '[31m'
    echo -n '[00m'
    
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

#=========================================================
# Customise
#=========================================================

#
# Alias
#

#alias asm='asm a.asm | sr'
#alias rmparent='rm ~/.mozilla/firefox/yan07onf.default/.parentlock'

alias rmast='rm *~'
alias rmdast='rm .*~'

alias cp='nocorrect cp -ir'
alias grep='nocorrect grep'
alias ln='nocorrect ln'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv -i'
alias setus='setxkbmap us'

#alias emacs='emacs23'
#alias emacsc='emacsclient23 -t'

alias viz='vi ~/.zshrc'
alias emz='emacs ~/.zshrc'
alias emcz='emacsc ~/.zshrc'
alias setz='source ~/.zshrc'

alias rdesktop='rdesktop -a 16 -g 1268x940'
alias uttsc='/opt/SUNWuttsc/bin/uttsc -g 1268x940'
alias dccs='/opt/SUNWuttsc/bin/uttsc -g 1200x900 cs-dc.cs.nitech.ac.jp'

alias dvipdf='dvipdfmx -d 5'

alias -g l='| $PAGER'
#alias -g g='| grep'

alias -g ...='../..'
alias -g ....='../../..'


#alias emacs='TERM=xterm-256color emacs'

#alias xine='xine --auto-play --auto-scan dvd'

#
# PATH
#
#export PATH=/usr/local/teTeX/bin:$PATH    # sh/bash ユーザの場合
export PATH=/opt/openoffice.org3/program:$PATH
#export PATH=/home/ikegaya/b4/compiler/p1/bin:$PATH

#
# terminal command overlap
#
export HISTCONTROL=ignoreboth


#
# zstyles
#
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1
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
#キーボード設定
#
#setxkbmap us
#xmodmap -eps G 64
#xmodmap -e 'keycode 64 = Alt_L Meta_L'
#xmodmap -eps G 64

#PATH=$PATH:~yasui/bin/
#itazura
#alias ls="itazura-ls"
#alias cd="echo 'rm -rf /'"

alias gitgraph="git log --graph --all --color  --pretty='%x09%h %cn%x09%s %Cred%d%Creset'"

# autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git
# autoload -Uz is-at-least
# if is-at-least 4.3.10; then
#     zstyle ':vcs_info:*' check-for-changes true
#     zstyle ':vcs_info:*' formats '%R' '%S' '%b' '%s' '%c' '%u'
#     zstyle ':vcs_info:*' actionformats '%R' '%S' '%b|%a' '%s' '%c' '%u'
# fi

# # zshのPTOMPTに渡す文字列は、可読性がそんなに良くなくて、読み書きしたり、つまりデバッグが
# # 大変なため、文字列を組み立てるのは関数でやることにする。
# # そのほうが分岐などを追加するのが楽。
# # この先、追加で表示させたい情報はいろいろでてくるとおもうし。

# autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git 

# # 下のformatsの値をそれぞれの変数に入れてくれる機能の、変数の数の最大。
# # デフォルトだと2くらいなので、指定しておかないと、下のformatsがほぼ動かない。
# zstyle ':vcs_info:*' max-exports 7

# # 左から順番に、vcs_info_msg_{n}_ という名前の変数に格納されるので、下で利用する
# zstyle ':vcs_info:*' formats '%R' '%S' '%b' '%s'
# # 状態が特殊な場合のformats
# zstyle ':vcs_info:*' actionformats '%R' '%S' '%b|%a' '%s'

# # 4.3.10以上の場合は、check-for-changesという機能を使う。
# function echo_rprompt () {
#     local repos branch st color

#     STY= LANG=en_US.UTF-8 vcs_info
#     if [[ -n "$vcs_info_msg_1_" ]]; then
#         # -Dつけて、~とかに変換
#         repos=`print -nD "$vcs_info_msg_0_"`

#         # if [[ -n "$vcs_info_msg_2_" ]]; then
#             branch="$vcs_info_msg_2_"
#         # else
#         #     branch=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
#         # fi

#         if [[ -n "$vcs_info_msg_4_" ]]; then # staged
#             branch="%F{green}$branch%f"
#         elif [[ -n "$vcs_info_msg_5_" ]]; then # unstaged
#             branch="%F{red}$branch%f"
#         else
#             branch="%F{blue}$branch%f"
#         fi

#         print -n "[%25<..<"
#         print -n "%F{yellow}$vcs_info_msg_1_%F"
#         print -n "%<<]"

#         print -n "[%15<..<"
#         print -nD "%F{yellow}$repos%f"
#         print -n "@$branch"
#         print -n "%<<]"

#     else
#         print -nD "[%F{yellow}%60<..<%~%<<%f]"
#     fi
# }

# setopt prompt_subst
# RPROMPT='`echo_rprompt`'