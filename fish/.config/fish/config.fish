# fish config

# powerline prompt
function fish_prompt
    ~/repos/powerline-shell/powerline-shell.py $status --shell bare ^/dev/null
end

# set PATH
set PATH /home/davide/.local/bin/ $PATH
