    if [ "11n" = "$1" -o "11b 11g 11n" = "$1" -o "11a 11n" = "$1" -o "11a 11n 11ac" = "$1" ]; then
	nmode=1
    else
	nmode=0
    fi
    echo "$nmode"
