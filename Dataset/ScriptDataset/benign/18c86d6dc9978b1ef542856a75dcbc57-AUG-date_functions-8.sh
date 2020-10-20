   DATE=$1
   ulog ddns status "getting seconds from $DATE"
   time=`echo $DATE | cut -f 2 -d '_'`
   ulog ddns status "time from $time"
   hr=`echo $time | cut -f 1 -d ':'`
   ulog ddns status "hour from $hr"
   min=`echo $time | cut -f 2 -d ':'`
   ulog ddns status "min from $min"
   sec=`echo $time | cut -f 3 -d ':'`
   ulog ddns status "sec from $sec"
   hr=`expr $hr \* 60`
   min=`expr $min + $hr`
   min=`expr $min \* 60`
   sec=`expr $sec + $min`
   
   ulog ddns status "calculated $sec"
   return $sec
   
