# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/davide/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
#export TERM=xterm-termite

alias ls='ls --color=auto'
alias iotop="sudo iotop"

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# set custom omz path
ZSH_CUSTOM=$HOME/.oh-my-zsh/


# powerlevel9k theme variables
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='foreground'
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
if [ "$TERM" != "linux" ]; then
	ZSH_THEME="powerlevel9k/powerlevel9k"
else
	ZSH_THEME="agnoster"
fi


# powerline theme variables
#POWERLINE_PATH="short"
#POWERLINE_NO_BLANK_LINE="true"
#POWERLINE_SHORT_HOST_NAME="true"
#POWERLINE_HIDE_HOST_NAME="true"
#POWERLINE_RIGHT_A="date"
#POWERLINE_TIME_FORMAT="%T{%H-%M}"


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git archlinux compleat)


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export EDITOR='vim'
export BROWSER='firefox-beta'

# config command to dotfiles git repo
alias config='/usr/bin/git --git-dir=/home/davide/dotfiles/.git/ --work-tree=/home/davide/dotfiles/'
alias matlab='matlab -desktop'

ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh



#PROMPT='%F{red}%n%f@%F{blue}%m%f %F{yellow}%1~%f %# '
#RPROMPT='[%F{yellow}%?%f]'

#bindkey "${terminfo[khome]}" beginning-of-line
#bindkey "${terminfo[kend]}" end-of-line

#bindkey "^[[5;5~" up-line-or-history
#history-beginning-search-backward
#bindkey "^[[6;5~" down-line-or-history
#history-beginning-search-forward

export KEYTIMEOUT=1

bindkey -r "^["
#bindkey "^[" send-break

autoload zkbd
source ~/.zkbd/xterm-termite-:0
#function zkbd_file() {
    #[[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
    #[[ -f ~/.zkbd/${TERM}-${DISPLAY}          ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}"          && return 0
    #return 1
#}

#[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
#keyfile=$(zkbd_file)
#ret=$?
#if [[ ${ret} -ne 0 ]]; then
    #zkbd
    #keyfile=$(zkbd_file)
    #ret=$?
#fi
#if [[ ${ret} -eq 0 ]] ; then
    #source "${keyfile}"
#else
    #printf 'Failed to setup keys using zkbd.\n'
#fi
#unfunction zkbd_file; unset keyfile ret

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char
[[ -n "$key[PageUp]"    ]] && bindkey -- "$key[PageUp]"        up-line-or-history
[[ -n "$key[PageDown]"  ]] && bindkey -- "$key[PageDown]"      down-line-or-history


