   DEV=$1
   DOWNLINK=$2
   UPLINK=$3
   HIGH=`dc $UPLINK 8 \* 15 \/ p`
   MEDIUM=`dc $UPLINK 4 \* 15 \/ p`
   NORMAL=`dc $UPLINK 2 \* 15 \/ p`
   LOW=`dc $UPLINK 1 \* 15 \/ p`
   r2q=10
   q_l=1000
   q_u=200000
   MIN_QUANTA=1500
   QUANTUM1=`dc $HIGH 131072 \* $r2q \/ p`
   QUANTUM2=`dc $MEDIUM 131072 \* $r2q \/ p`
   QUANTUM3=`dc $NORMAL 131072 \* $r2q \/ p`
   QUANTUM4=`dc $LOW 131072 \* $r2q \/ p`
   QUANTUM1=`echo "$QUANTUM1" | awk '{printf("%d\n",$1 + 0.5)}'`
   QUANTUM2=`echo "$QUANTUM2" | awk '{printf("%d\n",$1 + 0.5)}'`
   QUANTUM3=`echo "$QUANTUM3" | awk '{printf("%d\n",$1 + 0.5)}'`
   QUANTUM4=`echo "$QUANTUM4" | awk '{printf("%d\n",$1 + 0.5)}'`
   if [ $q_l -lt $QUANTUM1 -a $QUANTUM1 -lt $q_u -a $q_l -lt $QUANTUM2 -a $QUANTUM2 -lt $q_u -a $q_l -lt $QUANTUM3 -a $QUANTUM3 -lt $q_u -a $q_l -lt $QUANTUM4 -a $QUANTUM4 -lt $q_u ] ; then
      QUANTUM1=""
      QUANTUM2=""
      QUANTUM3=""
      QUANTUM4=""
      QUANTUM1=""
      QUANTUM2=""
      QUANTUM3=""
      QUANTUM4=""
   else
      if [ $q_u -lt $QUANTUM1 -o $q_u -lt $QUANTUM2 -o $q_u -lt $QUANTUM3 -o $q_u -lt $QUANTUM4 ] ; then
         QUANTUM1=$q_u
         QUANTUM2=`dc $QUANTUM1 2 \/ p`
         QUANTUM3=`dc $QUANTUM2 2 \/ p`
         QUANTUM4=`dc $QUANTUM3 2 \/ p`
      fi
      if [ $q_l -gt $QUANTUM1 -o $q_l -gt $QUANTUM2 -o $q_l -gt $QUANTUM3 -o $q_l -gt $QUANTUM4 ] ; then
         QUANTUM4=$MIN_QUANTA
         QUANTUM3=`dc $QUANTUM4 2 \* p`
         QUANTUM2=`dc $QUANTUM3 2 \* p`
         QUANTUM1=`dc $QUANTUM2 2 \* p`
      fi
      QUANTUM1="quantum $QUANTUM1"
      QUANTUM2="quantum $QUANTUM2"
      QUANTUM3="quantum $QUANTUM3"
      QUANTUM4="quantum $QUANTUM4"
   fi
   NOPRIOHOSTSRC=
   NOPRIOHOSTDST=
   NOPRIOPORTSRC=
   NOPRIOPORTDST=
   
   remove_wan_qos ${DEV}
   tc qdisc add dev ${DEV} root handle 1: prio bands 3 priomap 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
   tc qdisc add dev ${DEV} parent 1:1 handle 11: pfifo limit 10
   tc qdisc add dev ${DEV} parent 1:2 handle 12: pfifo limit 10
   if [ -z "$UPLINK" -o "0" = "$UPLINK" ] ; then
      tc qdisc add dev ${DEV} parent 1:3 handle 13: pfifo limit 20
      tc filter add dev ${DEV} parent 1:0 protocol ip prio 1 handle ${NETWORK_CONTROL_FW_MARK} fw classid 1:1
      tc filter add dev ${DEV} parent 1:0 protocol ip prio 1 handle ${VOICE_1_FW_MARK} fw classid 1:2
      tc filter add dev ${DEV} parent 1:0 protocol ip prio 1 handle ${VIDEO_1_FW_MARK} fw classid 1:2
   else
      tc qdisc add dev ${DEV} parent 1:3 handle 13: htb default 30 r2q $r2q
      tc class add dev ${DEV} parent 13: classid 13:1 htb rate ${UPLINK}mbit ceil ${UPLINK}mbit burst 6k
      tc class add dev ${DEV} parent 13:1 classid 13:10 htb rate ${HIGH}mbit ceil \
      ${UPLINK}mbit burst 6k prio 1 $QUANTUM1
      tc class add dev ${DEV} parent 13:1 classid 13:20 htb rate ${MEDIUM}mbit \
      ceil ${UPLINK}mbit burst 6k prio 2 $QUANTUM2
      tc class add dev ${DEV} parent 13:1 classid 13:30 htb rate ${NORMAL}mbit \
      ceil ${UPLINK}mbit burst 6k prio 2 $QUANTUM3 
      tc class add dev ${DEV} parent 13:1 classid 13:40 htb rate ${LOW}mbit ceil \
      ${UPLINK}mbit burst 6k prio 2 $QUANTUM4
      tc qdisc add dev ${DEV} parent 13:10 handle 10: sfq perturb 10
      tc qdisc add dev ${DEV} parent 13:20 handle 20: sfq perturb 10
      tc qdisc add dev ${DEV} parent 13:30 handle 30: sfq perturb 10
      tc qdisc add dev ${DEV} parent 13:40 handle 40: sfq perturb 10
      tc filter add dev ${DEV} parent 1:0 protocol ip prio 1 handle ${NETWORK_CONTROL_FW_MARK} fw classid 1:1
      tc filter add dev ${DEV} parent 1:0 protocol ip prio 1 handle ${VOICE_1_FW_MARK} fw classid 1:2
      tc filter add dev ${DEV} parent 1:0 protocol ip prio 1 handle ${VIDEO_1_FW_MARK} fw classid 1:2
      tc filter add dev $DEV parent 13:0 protocol ip prio 10 u32 match ip tos \
      0x10 0xff flowid 13:10
      tc filter add dev $DEV parent 13:0 protocol ip prio 10 u32 match ip \
      protocol 1 0xff flowid 13:10
      tc filter add dev $DEV parent 13: protocol ip prio 10 u32 \
         match ip protocol 6 0xff \
         match u8 0x05 0x0f at 0 \
         match u16 0x0000 0xffc0 at 2 \
         match u8 0x10 0xff at 33 \
         flowid 13:10
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 10 u32 match u8 0xa0 \
      0xe0 at 1 flowid 13:10
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${VOICE_2_FW_MARK} fw classid 13:10
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${VIDEO_2_FW_MARK} fw classid 13:10
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${VOICE_3_FW_MARK} fw classid 13:10
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${VIDEO_3_FW_MARK} fw classid 13:10
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${VOICE_4_FW_MARK} fw classid 13:10
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${BE_1_FW_MARK} fw classid 13:10
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 10 u32 match u8 0x80 \
      0xe0 at 1 flowid 13:20
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 10 u32 match u8 0x60 \
      0xe0 at 1 flowid 13:20
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${VIDEO_4_FW_MARK} fw classid 13:20
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${BE_2_FW_MARK} fw classid 13:20
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 10 u32 match u8 0x40 \
      0xe0 at 1 flowid 13:30
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${BE_3_FW_MARK} fw classid 13:30
      tc filter add dev $DEV parent 13:0 protocol ip prio 10 u32 match u8 0x20 \
      0xe0 at 1 flowid 13:40
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${BE_4_FW_MARK} fw classid 13:40
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${BK_1_FW_MARK} fw classid 13:40
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${BK_2_FW_MARK} fw classid 13:40
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${BK_3_FW_MARK} fw classid 13:40
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 11 handle ${BK_4_FW_MARK} fw classid 13:40
      tc filter add dev ${DEV} parent 13:0 protocol ip prio 12 handle ${GN_TC_FW_MARK} fw flowid 13:40
      for a in $NOPRIOPORTDST
      do
         tc filter add dev $DEV parent 13: protocol ip prio 14 u32  match ip dport $a 0xffff flowid 13:30
      done
      for a in $NOPRIOPORTSRC
      do
         tc filter add dev $DEV parent 13: protocol ip prio 15 u32  match ip sport $a 0xffff flowid 13:40
      done
      for a in $NOPRIOHOSTSRC
      do
         tc filter add dev $DEV parent 13: protocol ip prio 16 u32 match ip src $a flowid 13:40
      done
      for a in $NOPRIOHOSTDST
      do
         tc filter add dev $DEV parent 13: protocol ip prio 17 u32  match ip dst $a flowid 13:40
      done
      tc filter add dev $DEV parent 13: protocol ip prio 18 u32 match ip dst 0.0.0.0/0 flowid 13:30
   fi
