   if [ "1" = "$SYSCFG_ula_enable" ]
   then
      if [ -z "$SYSCFG_lan_ula_prefix" ] 
      then
         PREFIX="fd"
         MAC=`ip link show $SYSCFG_lan_ifname | grep link | awk '{print $2}'`
         SN=`syscfg get device serial_number`
         RANDOM_STRING=`echo ${SN}${MAC} | sha1sum`
         RANDOM_STRING=`echo $RANDOM_STRING | cut -d '-' -f1`
         LEN=`expr length $RANDOM_STRING`
         OFFSET=`expr $LEN - 10`
         PREFIX=${PREFIX}`echo ${RANDOM_STRING:${OFFSET}:2}`
         OFFSET=`expr $OFFSET + 2`
         for i in $OFFSET `expr $OFFSET + 4`
         do
            NEXTi=`expr $i + 2`
            PREFIX=${PREFIX}":"`echo ${RANDOM_STRING:${i}:2}``echo ${RANDOM_STRING:${NEXTi}:2}`
         done
         PREFIX=${PREFIX}"::"
         eval `ipv6_prefix_calc $PREFIX 48 0 0 2 64`
         if [ -n "$IPv6_PREFIX_1" ]
         then
            syscfg set lan_ula_prefix $IPv6_PREFIX_1
            SYSCFG_lan_ula_prefix=$IPv6_PREFIX_1
         fi
         if [ -z "$SYSCFG_lo_ula_prefix" -a -n "$IPv6_PREFIX_2" ]
         then
            syscfg set lo_ula_prefix $IPv6_PREFIX_2
            SYSCFG_lan_ula_prefix=$IPv6_PREFIX_2
         fi
         syscfg commit
      fi
   fi
