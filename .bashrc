# ~/.bashrc

# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# ignore specific command
HISTIGNORE="pwd:ls:ls -al:ll:la"

# add time in history
HISTTIMEFORMAT="%F %T "

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# colored prompt
PS1="\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;36m\]\w\[\e[0m\]\$ "

# Alias difinitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
