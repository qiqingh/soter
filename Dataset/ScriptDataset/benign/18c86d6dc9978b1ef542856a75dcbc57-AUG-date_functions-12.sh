   DAYS1=`days_from_basedate $1`
   DAYS2=`days_from_basedate $2`
   CUMMULATIVE_DAYS=`expr $DAYS2 - $DAYS1`
   echo "$CUMMULATIVE_DAYS"
