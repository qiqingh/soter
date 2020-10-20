   V6=`echo $1 | awk 'BEGIN { FS = "." } ; { printf ("%02x%02x:%02x%02x", $1, $2, $3, $4) }'`
   echo "$V6"                                                         
