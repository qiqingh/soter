   TIMESTAMP=$1
   DAY=0
   MONTH=0
   SAVEIFS=$IFS
   IFS=:
   for p in $TIMESTAMP
   do
      if [ "0" = "$MONTH" ] ; then
         MONTH=$p
      elif [ "0" = "$DAY" ] ; then
         DAY=$p
      fi
   done
   IFS=$SAVEIFS
   echo "$DAY"
