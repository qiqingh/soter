   OUR_MAC=`ip link show $1 | grep link | awk '{print $2}'`
   echo $OUR_MAC
