# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

test -s ~/.alias && . ~/.alias || true

# coloring red (better for root)
# PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '


#simple regular user
PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '

# fancy for regular user
#PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

export MANWIDTH=80

#userful title rename for tmux terminal-manager
ssh() {
	SSH_IP=`echo $1 | cut -d@ -f 2`
	# not exactly correct, but works in most cases
	if [ "$2" = "-p" ]; then
		SSH_PORT=":$3"
	fi

	# do not rename handwritten names (starting with #)
	# buggy after disconnect, but be so
	cur_name=`tmux display-message -p '#W' | sed 's/#\+$//'`
	if ! echo $cur_name | grep -q -E '^#'; then
		tmux rename-window "$SSH_IP$SSH_PORT"
	fi

	command ssh "$@"
	
	old_name=`tmux display-message -p '#W' | sed 's/#\+$//'`

	# do not rename if already marked disconnected
	if ! echo $old_name | grep -q -E '#$'; then
		tmux rename-window "$old_name#"
	fi
	#tmux rename-window "$old_name#"
}

