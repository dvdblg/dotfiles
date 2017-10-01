# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi


# set PATH so it includes user's private bin directories
PATH=$HOME/.local/bin:/usr/local/bin:$HOME/bin:$PATH
#PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# variables to export
#export TERMINAL=termite
#export LANGUAGE="en_US.UTF-8"
export LANGUAGE="it_IT.UTF-8"
export EDITOR=vim
export BROWSER='chromium'
#export TERMINFO=~/.terminfo
#export TERM='xterm-256color'

# aliases
steam() {
    LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' /usr/bin/steam
}

# config command to dotfiles git repo
alias config='/usr/bin/git --git-dir=/home/davide/dotfiles/.git/ --work-tree=/home/davide/dotfiles/'
alias matlab='matlab -desktop'
alias ls='ls --color=auto'
alias iotop="sudo iotop"
alias pacman="pacman --color=always"
alias pacaur="pacaur --color=always"
alias pactot="pacaur -Syyu --devel --needed"
alias aurinsd="pacaur -S --asdeps"
alias nvidia-smi="LD_PRELOAD=/usr/lib64/nvidia-bumblebee/libnvidia-ml.so nvidia-smi"
extract() {      # Handy Extract Program
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi

}

 #Setting the GEM_PATH and GEM_HOME variables may not be necessary, check 'gem env' output to verify whether both variables already exist
 GEM_HOME=$(ls -t -U | ruby -e 'puts Gem.user_dir')
 GEM_PATH=$GEM_HOME
 export PATH=$PATH:$GEM_HOME/bin
