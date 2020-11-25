# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/davide/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
    virtualenv
    archlinux
)

source $ZSH/oh-my-zsh.sh

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

export EDITOR='nvim'
export VISUAL='nvim'

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
compdef _pacman powerpill=pacman

alias kitty="kitty --single-instance"
alias vim="nvim"
#alias hc="herbstclient"

# ls
alias l='exa -lh --group-directories-first --color=always'
alias ll='exa -lah --group-directories-first --color=always'
alias la='exa -A --group-directories-first --color=always'
alias lm='exa -m --group-directories-first --color=always'
alias lr='exa -R --group-directories-first --color=always'
alias lg='exa -l'

# git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin master'

# mkdir + mv
mkmv() {
    mkdir -p -- "$argv[-1]"
    mv "$@"
}

mvdotfile() {
    mkdir -p -- $HOME/.dotfiles/$1/.config
    mv ~/.config/$1 $HOME/.dotfiles/$1/.config/
    stow -d ~/.dotfiles $1
}

confedit() {
    # author: OrionDB5
    if [[ -z $1 ]]; then
        echo "No config specified."
    elif [[ -f $1 ]]; then
        $EDITOR $1
    elif [[ -f "$HOME/.config/$1" ]]; then
        $EDITOR "$HOME/.config/$1"
    elif [[ -d "$HOME/.config/$1" ]]; then
        local CONFFOLDER="$HOME/.config/$1"
    elif [[ -d "$HOME/$1" ]]; then
        local CONFFOLDER="$HOME/$1"
    else
        local CONFFOLDER="$HOME"
    fi
    local pattern=".*/(.*config.*|.+\.conf|Main\.qml.*|.*autostart.*|(\.)?($1)rc.*)"
    local configs=($(find -L $CONFFOLDER/ -maxdepth 1 -type f -regextype posix-extended -regex $pattern))
    #echo $configs      # debug
    if [[ ${#configs[@]} -eq 0 ]]; then
    elif [[ ${#configs[@]} -eq 1 ]]; then
        $EDITOR "${configs}"
    else
        for c in "${configs[@]}"; do
            if [[ $c =~ .*\.in$ && -r $c ]]; then
                local FILE=$c;
                break
            elif [[ $c =~ $1rc\$ && -r $c ]]; then
                local FILE=$c
                break
            fi
        done
        if [[ -v FILE ]]; then
            $EDITOR $FILE
        else
            $EDITOR $CONFFOLDER
        fi
    fi
}

compdef "_files -W $HOME/.config/ " mvdotfile
local CONFFOLDERS=($HOME/.config $HOME)
compdef "_files -W CONFFOLDERS -g '*:directories *.in *conf* .*{rc,urxvt}'" confedit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
