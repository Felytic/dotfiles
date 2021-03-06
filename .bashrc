#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

# Make prompt looks like
# 12:24:27 user@host  git-branch ~/location
PS1="\[\e[35m\]\t\[\e[m\] \[\e[34m\]\u\[\e[m\]\[\e[1;34m\]@\[\e[m\]\[\e[32m\]\h\[\e[m\] \[\e[31m\]\$(parse_git_branch)\[\e[m\] \[\e[33m\]\w\[\e[m\] "

# Up/down arrow key searches through input command
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias v='nvim'
alias g='git'
alias r='ranger'
alias e='emacs'

# Do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'

# Confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Create parent directories on demand
alias mkdir='mkdir -pv'

alias py='bpython'

# Activate/deactivate virtualenv on entering/leaving a dir
function cd() {
  builtin cd $@

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./venv ]] ; then
        source ./venv/bin/activate
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
      fi
  fi
}
export HISTCONTROL=ignoreboth:erasedups
