   TIMESTAMP=$1
   MONTH=0
   SAVEIFS=$IFS
   IFS=:
   for p in $TIMESTAMP
   do
      if [ "0" = "$MONTH" ] ; then
         MONTH=$p
      fi
   done
   IFS=$SAVEIFS
   echo "$MONTH"
