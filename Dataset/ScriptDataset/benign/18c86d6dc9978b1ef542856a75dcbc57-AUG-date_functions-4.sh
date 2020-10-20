   TIMESTAMP=$1
   DAY=0
   MONTH=0
   YEAR=0
   YEAR2=0
   SAVEIFS=$IFS
   IFS=:
   for p in $TIMESTAMP
   do
      if [ "0" = "$MONTH" ] ; then
         MONTH=$p
      elif [ "0" = "$DAY" ] ; then
         DAY=$p
      elif [ "0" = "$YEAR" ] ; then
         YEAR=$p
      fi
   done
   IFS=_
   for p in $YEAR
   do
      if [ "0" = "$YEAR2" ] ; then
         YEAR2=$p
      fi
   done
   IFS=$SAVEIFS
   echo "$YEAR2"
