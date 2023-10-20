#    _               _
#   | |__   __ _ ___| |__  _ __ ___
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ | | | | | | (__
# (_|_.__/ \__,_|___|_| |_|_|  \___|


# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
   # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

	# If UID 0 is root
	if [[ $(id -u) -eq 0 ]];then
		# Prompt for the root user
		PS1="\[\e[0;91m\]┌\[\e[0;91m\][\[\e[0;38;5;44m\]\T\[\e[0;91m\]]─[\[\e[0m\]C:\[\e[0m\]\#\[\e[0;91m\]]─[\[\e[0m\]J:\[\e[0m\]\j\[\e[0;91m\])\n\$(if [[ \$? != 0 ]];then echo \"\[\e[0;91m\]├─[\[\e[0;1;3;91m\]X\[\e[0m\]]─[\[\e[0;5;91m\]root\[\e[0;38;5;222m\]@\[\e[0;32m\]\h\[\e[0;91m\]]─[\[\e[0;1;38;5;38m\]\w\[\e[0;91m\]]\"; else echo \"\[\e[0;91m\]├─\[\e[0;91m\][\[\e[0;5;91m\]root\[\e[0;38;5;222m\]@\[\e[0;32m\]\h\[\e[0;91m\]]\[\e[0;91m\]─\[\e[0;91m\][\[\e[0;1;38;5;38m\]\w\[\e[0;91m\]]\"; fi)\n\[\e[0;91m\]└──╼ \[\e[0;38;5;222m\]# \[\e[0m\]"
	else
		# Prompt for normal user
        PS1="\$(if [[ \$? != 0 ]];then echo \"\[\e[0;91m\]┌─[\[\e[0;1;3;91m\]X\[\e[0m\]]─[\[\e[0;32m\]\u\[\e[0;38;5;222m\]@\[\e[0;32m\]]\h\[\e[0;91m\]]─[\[\e[0;1;38;5;38m\]\w\[\e[0;91m\]]\"; else echo \"\[\e[0;91m\]┌─[\[\e[0;91m\]\[\e[0;32m\]\u\[\e[0;38;5;222m\]@\[\e[0;32m\]\h\[\e[0;91m\]]─[\[\e[0;1;38;5;38m\]\w\[\e[0;91m\]]\"; fi)\n\[\e[0;91m\]└──╼ \[\e[0;38;5;222m\]\$ \[\e[0m\]"
	fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# If tmux isn't already running, start it
# if ! command -v tmux >> /dev/null 2>&1
# then
#     echo "tmux isn't installed."
#     echo "Please use your distribution's package manager to install it."
# else
#     if [ -z "$TMUX" ]; then
#         tmux attach || exec tmux new-session
#     else
#         echo "already in tmux!"
#     fi
# fi
#
# Environment variables for Rep Diary Export
export X_AUTH_ID="33cc47af-aeab-48cb-93a2-ef58dfe35030"
export X_USER_ID="62e3ba9294bdf800071d04ff"
export X_DEVICE_ID="9735DAF2-00AA-4F88-A908-D185C8E76EFB"
export X_TIMESTAMP_HASH="ZDMzNzU0YTY1ZjcyODAzNWI5ZWJlOTdiMmNjZDEwZjVlODI3ZjMyNTg5MzU2NWVhYTVkMjE2NWJlNjdhNzNmNjY4ZWE3Yjg3MmYxNmJkNDQ2ZmQ5ODg1MjljMTRhYzRhZGMwMjcwNGM5MWJhNmI3ZGNkYTA2ZWI2OTgxYjhkODU="
