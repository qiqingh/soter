get_network () {
   TEMP=""
   LAST=""
   SAVEIFS=$IFS
   IFS=.
   for p in $1
   do
       if [ "" = "$LAST" ] ; then
          LAST=$TEMP
       else
          LAST=$LAST"."$TEMP
       fi
       TEMP=$p
   done
   IFS=$SAVEIFS
   echo $LAST
}
