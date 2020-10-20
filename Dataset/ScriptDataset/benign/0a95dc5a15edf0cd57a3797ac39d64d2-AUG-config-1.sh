    if [ -n "$(type -t __${1})" ]; then
        __${1} "${@:2}"
        exit 1
    elif [ -n "$(type -t __)" ]; then
        __ ${@}
    fi

    exit 0
