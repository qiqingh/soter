   ip link set $1 up
   ip link set $1 allmulticast on
   brctl addif $2 $1
