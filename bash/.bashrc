#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#export TERM=rxvt-unicode-256color
#export TERM=xterm-termite
export PATH=$PATH:$HOME/.local/bin

alias ls='ls --color=auto'
alias iotop="sudo iotop"
PS1='[\u@\h \W]\$ '

export EDITOR=vim
export BROWSER=firefox-beta

#export _JAVA_AWT_WM_NONREPARENTING=1

# Colors
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
GRAY="$(tput setaf 8)"
BOLD="$(tput bold)"
UNDERLINE="$(tput sgr 0 1)"
INVERT="$(tput sgr 1 0)"
NOCOLOR="$(tput sgr0)"

# Hide user
local_username="davidebelgenio"

# Symbols
prompt_symbol="❯"
prompt_clean_symbol="☀ "
prompt_dirty_symbol="☂ "
prompt_venv_symbol="☁ "

function prompt_command() {
	# Local or SSH session?
	local remote=
	[ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] && remote=1

	# Git branch name and work tree status (only when we are inside Git working tree)
	local git_prompt=
	if [[ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
		# Branch name
		local branch="$(git symbolic-ref HEAD 2>/dev/null)"
		branch="${branch##refs/heads/}"

		# Working tree status (red when dirty)
		local dirty=
		# Modified files
		git diff --no-ext-diff --quiet --exit-code --ignore-submodules 2>/dev/null || dirty=1
		# Untracked files
		[ -z "$dirty" ] && test -n "$(git status --porcelain)" && dirty=1

		# Format Git info
		if [ -n "$dirty" ]; then
			git_prompt=" $RED$prompt_dirty_symbol$branch$NOCOLOR"
		else
			git_prompt=" $GREEN$prompt_clean_symbol$branch$NOCOLOR"
		fi
	fi

	# Virtualenv
	local venv_prompt=
	if [ -n "$VIRTUAL_ENV" ]; then
	    venv_prompt=" $BLUE$prompt_venv_symbol$(basename $VIRTUAL_ENV)$NOCOLOR"
	fi

	# Only show username if not default
	local user_prompt=
	[ "$USER" != "$local_username" ] && user_prompt="$user_color$USER$NOCOLOR"

	# Show hostname inside SSH session
	local host_prompt=
	[ -n "$remote" ] && host_prompt="@$YELLOW$HOSTNAME$NOCOLOR"

	# Show delimiter if user or host visible
	local login_delimiter=
	[ -n "$user_prompt" ] || [ -n "$host_prompt" ] && login_delimiter=":"

	# Format prompt
	first_line="$user_prompt$host_prompt$login_delimiter$WHITE\w$NOCOLOR$git_prompt$venv_prompt"
	# Text (commands) inside \[...\] does not impact line length calculation which fixes stange bug when looking through the history
	# $? is a status of last command, should be processed every time prompt prints
	second_line="\`if [ \$? = 0 ]; then echo \[\$CYAN\]; else echo \[\$RED\]; fi\`\$prompt_symbol\[\$NOCOLOR\] "
	PS1="\n$first_line\n$second_line"

	# Multiline command
	PS2="\[$CYAN\]$prompt_symbol\[$NOCOLOR\] "

	# Terminal title
	local title="$(basename "$PWD")"
	[ -n "$remote" ] && title="$title \xE2\x80\x94 $HOSTNAME"
	echo -ne "\033]0;$title"; echo -ne "\007"
}

# Show awesome prompt only if Git is istalled
command -v git >/dev/null 2>&1 && PROMPT_COMMAND=prompt_command

# config command to dotfiles git repo
alias config='/usr/bin/git --git-dir=/home/davide/dotfiles/.git/ --work-tree=/home/davide/dotfiles/'

alias matlab='matlab -desktop'

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
