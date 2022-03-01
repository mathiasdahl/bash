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

adal () {
  echo alias $1="'$2'" >> ~/.bash_aliases
  echo Alias file tail:
  tail ~/.bash_aliases
  source ~/.bash_aliases
}
