  #Credits: Based on a script by mbm of openwrt.org
  DDNSACACHE=$(wget -O - http://checkip.sipwerk.com|sed s/[^0-9.]//g)
   [ "$DDNSDCACHE" != "$DDNSACACHE" ] && {                           
      wget -O /dev/null http://$DDNSUSERNM:$DDNSPASSWD@$DDNSSERVER/nic/update?hostname=$DDNSHOSTNM &&
      DDNSDCACHE=$DDNSACACHE
   }                     
