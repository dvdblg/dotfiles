typeset -U path
path=(~/.local/bin $path[@])
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'
