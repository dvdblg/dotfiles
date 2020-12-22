# make zsh usable
autoload -Uz compinit
compinit

autoload -U promptinit; promptinit
prompt spaceship

autoload -U select-word-style
select-word-style bash
export WORDCHARS='.-'

source .key-bindings.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory


# window title, source: http://blog.bstpierre.org/zsh-prompt
function title() {
    # escape '%' chars in $1, make nonprintables visible
    local a=${(V)1//\%/\%\%}

    # Truncate command, and join lines.
    a=$(print -Pn "%40>...>$a" | tr -d "\n")
    case $TERM in
        screen*)
            print -Pn "\e]2;$a @ $2\a" # plain xterm title
            print -Pn "\ek$a\e\\"      # screen title (in ^A")
            print -Pn "\e_$2   \e\\"   # screen location
            ;;
        xterm*)
            print -Pn "\e]2;$a @ $2\a" # plain xterm title
            ;;
    esac
}

# precmd is called just before the prompt is printed
function precmd() {
    title "zsh" "%m:%55<...<%~"
}
# preexec is called just before any command line is executed
function preexec() {
    title "$1" "%m:%35<...<%~"
}

# variables
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


# aliases
compdef _pacman powerpill=pacman

alias chromium="chromium $(tr '\n' ' ' < ~/.config/chromium-flags.conf)"
alias kitty="kitty --single-instance"
alias vim="nvim"
alias xis="~/void-packages/xbps-src"
alias xir="xbps-remove"

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
  local CONFIG
  if [ -d "$HOME/.config/$1" ]; then
    CONFIG=$1
  else
    CONFIG=$(echo "$1" | cut -d'.' -f 1)
  fi
  mkdir -p -- $HOME/.dotfiles/$CONFIG/.config
  mv ~/.config/$1 $HOME/.dotfiles/$CONFIG/.config/
  stow -d ~/.dotfiles $CONFIG
}

confedit() {
    # author: OrionDB5

    # handle special cases
    case $1 in
      autostart)  $EDITOR "$HOME/.local/bin/autostart.sh" ;;
      preprocess) $EDITOR "$HOME/.local/bin/preprocess_configs.sh" ;;
      firefox)    $EDITOR "$HOME/.mozilla/firefox/trktth22.default-release/chrome/userChrome.css.in" ;;
      user.js)    $EDITOR "$HOME/.mozilla/firefox/trktth22.default-release/user.js" ;;
      nm)         $EDITOR "$HOME/.dotfiles/NetworkManager/etc/NetworkManager/NetworkManager.conf" ;;
      tlp)        sudo $EDITOR "/etc/tlp.conf" ;;
      *)
        # handle common configs
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
        elif [[ -f "$HOME/.$1rc" ]]; then
          local CONFFOLDER="$HOME"
        # create config if it doesn't exists
        elif [[ ! -f $1 ]]; then
          $EDITOR config.tmp
          [[ -f config.tmp ]] && mkdir "$HOME/.config/$1" && mv config.tmp "$HOME/.config/$1/config"
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
        ;;
    esac
}

compdef "_files -W $HOME/.config/ " mvdotfile
local CONFFOLDERS=($HOME/.config $HOME)
compdef "_files -W CONFFOLDERS -g '*:directories *.in *conf* .*{rc,urxvt}'" confedit

fpath=($fpath "/home/da/.zfunctions")
fpath=($fpath "/home/da/.zfunctions")
