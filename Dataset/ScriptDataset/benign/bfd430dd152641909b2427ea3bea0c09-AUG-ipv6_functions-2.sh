   RANDOM_64=`cat /dev/urandom | tr -cd 'a-f0-9' | head -c 4`
   RANDOM_64=$RANDOM_64":`cat /dev/urandom | tr -cd 'a-f0-9' | head -c 4`"
   RANDOM_64=$RANDOM_64":`cat /dev/urandom | tr -cd 'a-f0-9' | head -c 4`"
   RANDOM_64=$RANDOM_64":`cat /dev/urandom | tr -cd 'a-f0-9' | head -c 4`"
   echo "above errors produced by ipv6_functions.sh::create_random_64 are not service affecting" > /dev/console
