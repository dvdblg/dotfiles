#
# User configuration sourced by interactive shells
#

#source $HOME/.profile

# Change default zim location 
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Source zim
if [[ -s ${ZIM_HOME}/init.zsh ]]; then
  source ${ZIM_HOME}/init.zsh
fi


# Lines configured by zsh-newuser-install
#HISTFILE=~/.zsh_history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt autocd
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/home/davide/.zshrc'

#autoload -Uz compinit
#compinit
# End of lines added by compinstall

export KEYTIMEOUT=1

#bindkey -r "^["
#bindkey "^[" send-break
#bindkey "${terminfo[kcuu1]}" history-substring-search-up
#bindkey "${terminfo[kcud1]}" history-substring-search-down

#autoload -U promptinit; promptinit
#prompt pure


