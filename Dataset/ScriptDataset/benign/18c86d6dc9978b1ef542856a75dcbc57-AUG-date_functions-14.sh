   MINS1=`mins_from_basedate $1`
   MINS2=`mins_from_basedate $2`
   CUMMULATIVE_MINS=`expr $MINS2 - $MINS1`
   echo "$CUMMULATIVE_MINS"
