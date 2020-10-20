    [ -f $2 ] && {
        echo $1 > $2
        echo -n $1 ">" $2, "= "
        cat $2
    }
