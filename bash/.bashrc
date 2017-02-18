#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export TERM=rxvt-unicode-256color
export PATH=$PATH:$HOME/.local/bin

alias ls='ls --color=auto'
alias iotop="sudo iotop"
PS1='[\u@\h \W]\$ '

export EDITOR=nano
export BROWSER=firefox-beta

export _JAVA_AWT_WM_NONREPARENTING=1

function _update_ps1() {
    PS1="$(~/repos/powerline-shell/powerline-shell.py $? 2> /dev/null)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
#alias config='/usr/bin/git --git-dir=/home/davide/.cfg/ --work-tree=/home/davide'

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
