   if [ -z "$4" -o -z "$3" -o -z "$2" -o -z "$1" ] ; then
      RANDOM_SUBNET=
      return 
   fi
   if [ -n "$5" ]
   then
      FORBIDDEN_FIRST_OCTET=`echo $5 | awk 'BEGIN { FS = "." } ; { printf ($1) }'` 
      if [ "192" = "$FORBIDDEN_FIRST_OCTET" ] ; then
         OCTET1A=10
         OCTET1B=172
      elif [ "172" = "$FORBIDDEN_FIRST_OCTET" ] ; then
         OCTET1A=10
         OCTET1B=192
      elif [ "10" = "$FORBIDDEN_FIRST_OCTET" ] ; then
         OCTET1A=172
         OCTET1B=192
      else
         RANDOM=`expr $1 \* $3`
         NETWORK=`expr $RANDOM % 99`
         if [ "1" = "$NETWORK" ] 
         then
            OCTET1A=192
            OCTET1B=172
         elif [ "11" -gt "$NETWORK" ]
         then
            OCTET1A=172
            OCTET1B=192
         else
            OCTET1A=10
            OCTET1B=192
         fi 
      fi
   else
      RANDOM=`expr $1 \* $3`
      NETWORK=`expr $RANDOM % 99`
      if [ "1" = "$NETWORK" ] 
      then
         OCTET1A=192
         OCTET1B=172
      elif [ "11" -gt "$NETWORK" ]
      then
         OCTET1A=172
         OCTET1B=192
      else
         OCTET1A=10
         OCTET1B=192
      fi 
   fi
   if [ "192" = "$OCTET1A" ]
   then
      OCTET2A=168
   elif [ "172" = "$OCTET1A" ]
   then
      RANDOM=`expr $RANDOM + $2`
      OCTET2A=`expr $RANDOM % 49`
      if [ "32" -lt "$OCTET2A" ]
      then
         OCTET2A=`expr $OCTET2A - 16`
      elif [ "16" -gt "$OCTET2A" ] 
      then
         OCTET2A=`expr $OCTET2A + 16`
      fi
   else 
      RANDOM=`expr $RANDOM + $2`
      OCTET2A=`expr $RANDOM % 256`
   fi
   RANDOM=`expr $RANDOM + $2`
   OCTET3A=`expr $RANDOM % 256`
   RANDOM=`expr $RANDOM - $3`
   OCTET4A=`expr $RANDOM % 255`
   if [ "0" -eq $OCTET4A ]
   then
      OCTET4A=65
   fi
   if [ "192" = "$OCTET1B" ]
   then
      OCTET2B=168
   elif [ "172" = "$OCTET1B" ]
   then
      RANDOM=`expr $RANDOM + $2`
      OCTET2B=`expr $RANDOM % 49`
      if [ "32" -lt "$OCTET2B" ]
      then
         OCTET2B=`expr $OCTET2B - 16`
      elif [ "16" -gt "$OCTET2B" ]
      then
         OCTET2B=`expr $OCTET2B + 16`
      fi
   else
      RANDOM=`expr $RANDOM + $2`
      OCTET2B=`expr $RANDOM % 256`
   fi
   RANDOM=`expr $RANDOM + $2`
   OCTET3B=`expr $RANDOM % 256`
   RANDOM=`expr $RANDOM - $3`
   OCTET4B=`expr $RANDOM % 255`
   if [ "0" -eq $OCTET4B ]
   then
      OCTET4B=27
   fi
   eval `ipcalc -n ${OCTET1A}.${OCTET2A}.${OCTET3A}.${OCTET4A}/${4}`
   RANDOM_SUBNET_1=$NETWORK
   eval `ipcalc -n ${OCTET1B}.${OCTET2B}.${OCTET3B}.${OCTET4B}/24`
   RANDOM_SUBNET_2=$NETWORK
