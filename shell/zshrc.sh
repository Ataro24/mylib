setopt prompt_subst
export PAGER="less"
export LESS="-imqMXR -x 8"
export LESSCHARSET=utf-8
export EDITOR="vi"

export TEXMFHOME=~/texmf	# dont set TEXINPUTS
export BIBCITEDIR=${TEXMFHOME}/bibtex/bib
export LANG=ja_JP.UTF-8

#
# util aliases
#
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -lh -A'
alias du='du -hk'
alias grep='nocorrect grep --no-message --color'
alias cp='nocorrect cp -ir'
alias ln='nocorrect ln'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv -i'
alias setus='setxkbmap us'
alias gitgraph="git log --graph --all --color  --pretty='%x09%h %cn%x09%s %Cred%d%Creset'"


# リダイレクトの際に上書きしない
set -o noclobber

# user file-creation mask
umask 022

# 補完を有効に
autoload -Uz compinit
compinit
#補完でカラーの使用
autoload colors
export LS_COLORS='di=01;34'

# emacs風キーバインド
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
    alias ls='ls -F --color -G'
    ;;
esac


#
# コマンド履歴
#
export HISTCONTROL=ignoreboth
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

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

#
# rbenvがあれば有効化
#
if [ -e $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
