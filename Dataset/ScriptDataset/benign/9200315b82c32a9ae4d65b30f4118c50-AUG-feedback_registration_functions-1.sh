   LISTOF_EVENTS=$1
   if [ -n "$LISTOF_EVENTS" ] && [ "NULL" != "$LISTOF_EVENTS" ] ; then 
	SAVEIFS=$IFS
	IFS=';'
	for custom in $LISTOF_EVENTS ; do
		if [ -n "$custom" ] && [ " " != "$custom" ] ; then
		IFS=$SAVEIFS
		map_sysevent_to_handler $custom
		IFS=';'
		fi
	done
	IFS=$SAVEIFS
   fi
