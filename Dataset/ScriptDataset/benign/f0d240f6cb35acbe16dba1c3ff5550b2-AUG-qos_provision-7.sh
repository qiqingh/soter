   DEV=$1
   tc qdisc del dev ${DEV} root  2> /dev/null > /dev/null
