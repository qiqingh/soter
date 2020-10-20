    if [ -z $1 ] ; then
	mf_feedback "Updating router audit (http)..."
    fi
    PUPTIME=$(( $(cat /proc/uptime | awk -F . '{print $1}';) / 3600 ))
    DOTPUPTIME=$(( $(( $(cat /proc/uptime | awk -F . '{print $1}';) - $(( $PUPTIME * 3600 )) )) / 36 ))
    wget -O - http://$USERNAME:$PASSWORD@audit.milkfish.org/audits?uptime=\
$(cat /proc/uptime| awk 'sub(" ", "_") {print}';)\&btime=$(cat /proc/stat | grep btime | awk '{print $2}';)\
_$(date +%s)\&puptime=$PUPTIME.$DOTPUPTIME\
\&routerid=$(nvram get milkfish_username)_$(nvram get milkfish_routerid)$(md5sum $0 | awk '{print $1}')
