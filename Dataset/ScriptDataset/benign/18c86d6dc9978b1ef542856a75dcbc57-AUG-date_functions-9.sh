   MONTH=$1
   if [ "2" = "$MONTH" ] ; then
      echo "28"
   elif [ "02" = "$MONTH" ] ; then
      echo "28"
   elif [ "4" = "$MONTH" ] ; then
      echo "30"
   elif [ "4" = "$MONTH" ] ; then
      echo "30"
   elif [ "04" = "$MONTH" ] ; then
      echo "30"
   elif [ "6" = "$MONTH" ] ; then
      echo "30"
   elif [ "06" = "$MONTH" ] ; then
      echo "30"
   elif [ "9" = "$MONTH" ] ; then
      echo "30"
   elif [ "09" = "$MONTH" ] ; then
      echo "30"
   elif [ "11" = "$MONTH" ] ; then
      echo "30"
   else
      echo "31"
   fi
