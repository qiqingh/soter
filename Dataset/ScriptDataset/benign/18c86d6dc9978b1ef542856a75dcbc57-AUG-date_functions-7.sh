   TIMESTAMP=$1
   STRING1=""
   STRING2=""
   SAVEIFS=$IFS
   IFS=_
   for p in $TIMESTAMP
   do
      if [ "" = "$STRING1" ] ; then
         STRING1=$p
      elif [ "" = "$STRING2" ] ; then
         STRING2=$p
      fi
   done
   HOUR=0
   MIN=0
   SEC=0
   IFS=:
   for p in $STRING2
   do
      if [ "0" = "$HOUR" ] ; then
         HOUR=$p
      elif [ "0" = "$MIN" ] ; then
         MIN=$p
      elif [ "0" = "$SEC" ] ; then
         SEC=$p
      fi
   done
   IFS=$SAVEIFS
   echo "$SEC"
