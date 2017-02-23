# fish config

# powerline prompt
function fish_prompt
    ~/repos/powerline-shell/powerline-shell.py $status --shell bare ^/dev/null
end

# set PATH
set PATH /home/davide/.local/bin/ $PATH

# set EDITOR and BROWSER
set EDITOR vim
set BROWSER firefox-beta

 alias config "/usr/bin/git --git-dir=/home/davide/dotfiles/.git/ --work-tree=/home/davide/dotfiles/"
