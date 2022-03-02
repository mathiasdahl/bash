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

adal() {
    if [[ -z "$1" || -z "$2"  ]]
    then
        echo Hey! I need two arguments!
    else
        echo alias $1\=\'$2\' >>~/.bash_aliases
        . ~/.bash_aliases
    fi
}

cdd() {
    cd *$1*
}

pp() {
    cd "$(find /c/prj/ -maxdepth 1 -type d -name "*$1*" | head -n 1)"
}

# Modify cd to save a history of directories I visit

cd() {
    if [[ -z "$1" ]]
    then
        builtin cd
    else
        builtin cd $1
    fi

    # Trying to have this execute in a sub shell
    # so that the user get back control directly.
    
    (
        if grep -x `pwd` $CDHF
        then
            : # too lazy to find out how to negate the if above...
        else
#                         echo Inside `pwd` ...
            echo `pwd` >> $CDHF
#                         echo Content of $CDHF:
#                         cat $CDHF
#                         echo Trimming...
            tmpfile=$(mktemp)
#                         echo tmpfile = ${tmpfile}
            tail -n 20 $CDHF > ${tmpfile}
#                         echo content of tmpfile:
#                         cat ${tmpfile}
#                         echo Overwriting $CDHF
            cat ${tmpfile} > $CDHF
#                         echo Content of $CDHF:
#                         cat $CDHF
#                         echo Removing tmpfile
            rm ${tmpfile}
        fi
    )
    
}

ch() {
    maxhistorylines=20
    if [[ -z "$1" ]]
    then
        tail -n $maxhistorylines $CDHF | awk '{printf "%d\t%s\n", NR, $0}'
    else
        re='^[0-9]+$'
        if [[ $1 =~ $re ]] ; then
            cd "$(tail -n $maxhistorylines $CDHF | sed -n "$1p")" > /dev/null
        else
            cd "$(grep -E -i "$1" $CDHF | head -n 1)" > /dev/null
        fi
    fi 
}
