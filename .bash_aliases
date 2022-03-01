cl () {
   DIR="$*"
   if [ $# -lt 1 ]
   then
       DIR=$HOME
   fi
   builtin cd "${DIR}" && ls -F --color=auto
}

mcd () {
   mkdir -p $1
   cd $1
}

alias rm='rm -i'
alias ..='cd ..'
alias ll='ls -l'
alias lrt='ls -lrt'
alias lart='ls -lart'
alias la='ls -la'
alias ffi='find . -iname'
alias mkdir='mkdir -pv'
alias hg='history | grep'
alias ha='history -a'

