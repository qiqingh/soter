   PREFIX=$1
   PREFIX_LENGTH=$2
   IP_ADDRESS=$3
   MASK_BITS=$4
   NUM_SUBNETS=$5
   MINIMUM_NETWORK_SIZE=$6
   if [ -z "$MINIMUM_NETWORK_SIZE" ] ; then
      MINIMUM_NETWORK_SIZE=0
   fi
   if [ -z "$NUM_SUBNETS" ] ; then
      NUM_SUBNETS=1
   fi
   if [ -z "$MASK_BITS" ] ; then
      MASK_BITS=0
   fi
   if [ -z "$IP_ADDRESS" ] ; then
      IP_ADDRESS=0
      MASK_BITS=0
   fi
   if [ "0" != "$PREFIX" -o "0" = "$PREFIX_LENGTH" ] ; then
      SHIFT_BY=`expr 128 - $PREFIX_LENGTH` 
      eval `ip6calc -r $PREFIX $SHIFT_BY`
      eval `ip6calc -l $SHIFT $SHIFT_BY`
      PREFIX=$SHIFT
   else
      PREFIX="::"
      PREFIX_LENGTH=0
   fi
   if [ "0" != "$IP_ADDRESS" ] ; then
      eval `ip6calc -4 $IP_ADDRESS`
      IP_ADDRESS=$IPv4_MAPPED
      if [ $MASK_BITS -gt 0 ] ; then
         eval `ip6calc -l $IP_ADDRESS $MASK_BITS`
         eval `ip6calc -a $SHIFT ::255.255.255.255`
         IP_ADDRESS=$AND
      fi
      SHIFT_BY=`expr 96 - $PREFIX_LENGTH`
      eval `ip6calc -l $IP_ADDRESS $SHIFT_BY`
      IP_ADDRESS=$SHIFT
      eval `ip6calc -o $PREFIX $IP_ADDRESS`
      PREFIX="$OR"
      PREFIX_LENGTH=`expr $PREFIX_LENGTH + 32 - $MASK_BITS`
   fi
   if [ "64" -lt "$PREFIX_LENGTH" ] ; then
      echo "IPv6_PREFIX_1=${PREFIX}/${PREFIX_LENGTH}"
      return
   else
      if [ "$NUM_SUBNETS" -le  "2" ] ; then
         SUBNET_BITS=1
      elif [ "$NUM_SUBNETS" -le  "4" ] ; then
         SUBNET_BITS=2
      elif [ "$NUM_SUBNETS" -le  "8" ] ; then
         SUBNET_BITS=3
      elif [ "$NUM_SUBNETS" -le  "16" ] ; then
         SUBNET_BITS=4
      elif [ "$NUM_SUBNETS" -le  "32" ] ; then
         SUBNET_BITS=5
      else 
         SUBNET_BITS=6
      fi
      if [ "$PREFIX_LENGTH" -ge "64" ] ; then
         NUM_SUBNETS=1
         SUBNET_BITS=0
      elif [ "$PREFIX_LENGTH" -eq "63" ] ; then
         if [ "$SUBNET_BITS" -gt "1" ] ; then
            NUM_SUBNETS=2
            SUBNET_BITS=1
         fi
      elif [ "$PREFIX_LENGTH" -eq "62" ] ; then
         if [ "$SUBNET_BITS" -gt "2" ] ; then
            NUM_SUBNETS=4
            SUBNET_BITS=2
         fi
      elif [ "$PREFIX_LENGTH" -eq "61" ] ; then
         if [ "$SUBNET_BITS" -gt "3" ] ; then
            NUM_SUBNETS=8
            SUBNET_BITS=3
         fi
      elif [ "$PREFIX_LENGTH" -eq "60" ] ; then
         if [ "$SUBNET_BITS" -gt "4" ] ; then
            NUM_SUBNETS=16
            SUBNET_BITS=4
         fi
      elif [ "$PREFIX_LENGTH" -eq "59" ] ; then
         if [ "$SUBNET_BITS" -gt "5" ] ; then
            NUM_SUBNETS=32
            SUBNET_BITS=5
         fi
      elif [ "$PREFIX_LENGTH" -eq "58" ] ; then
         if [ "$SUBNET_BITS" -gt "6" ] ; then
            NUM_SUBNETS=64
            SUBNET_BITS=6
         fi
      else  
         if [ "$SUBNET_BITS" -gt "6" ] ; then
            NUM_SUBNETS=64
            SUBNET_BITS=6
         fi
      fi
      SHIFTBY_OFFSET=`expr 128 - $PREFIX_LENGTH - $SUBNET_BITS`
      PREFIX_LENGTH=`expr $PREFIX_LENGTH + $SUBNET_BITS`
      OUTPUT_PREFIX_LENGTH=$PREFIX_LENGTH
      if [ "0" != "$MINIMUM_NETWORK_SIZE" ] ; then
         if [ "$MINIMUM_NETWORK_SIZE" -gt "$OUTPUT_PREFIX_LENGTH" ] ; then
            OUTPUT_PREFIX_LENGTH=$MINIMUM_NETWORK_SIZE
         fi
      fi
      index=0
      while [ "$index" -lt "$NUM_SUBNETS" ] ; do
         if [ "0" != "$index" ] ; then
            eval `ip6calc -4 0.0.0.${index}`
            eval `ip6calc -l $IPv4_MAPPED $SHIFTBY_OFFSET`
            eval `ip6calc -o $PREFIX $SHIFT`
            SUBNET="$OR"
         else
            SUBNET="$PREFIX"
         fi
         I=`expr $index + 1`
         echo -n "IPv6_PREFIX_${I}=${SUBNET}/${OUTPUT_PREFIX_LENGTH} "
         index=`expr $index + 1`
      done 
   fi 
