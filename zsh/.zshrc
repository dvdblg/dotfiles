autoload -Uz compinit
compinit
autoload -U promptinit; promptinit
prompt spaceship

export EDITOR='nvim'
export VISUAL='nvim'

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


# aliases
compdef _pacman powerpill=pacman

alias kitty="kitty --single-instance"
alias vim="nvim"
#alias hc="herbstclient"

## ls
alias l='exa -lh --group-directories-first --color=always'
alias ll='exa -lah --group-directories-first --color=always'
alias la='exa -A --group-directories-first --color=always'
alias lm='exa -m --group-directories-first --color=always'
alias lr='exa -R --group-directories-first --color=always'
alias lg='exa -l'

## git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin master'

## mkdir + mv
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


