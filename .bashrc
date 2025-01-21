#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nv='nvim'
alias ff='fastfetch'
alias pipes='pipes.sh'

export PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH
# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export EDITOR=nvim

color_reset='\[\033[0m\]'
separator='❯'

PS1="\[\e[1;96m\]Hyperion \[\e[38;5;93m\]\w \[\e[1;96m\]$separator$color_reset "

# Created by `pipx` on 2025-01-21 15:24:32
export PATH="$PATH:/home/hyperion/.local/bin"
