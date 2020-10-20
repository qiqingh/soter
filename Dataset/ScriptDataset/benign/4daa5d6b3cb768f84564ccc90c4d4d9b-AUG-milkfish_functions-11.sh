    echo "$(openserctl ps | grep child=0\ sock=; openserctl ps | grep child=0\ sock=1; openserctl ps | grep child=0\ sock=2;)"
    echo ""
    echo "RTPproxy:"
    echo "$(ps | grep 'rtpproxy -l' | grep -v 'grep' | cut -f2 -d'l' | awk 'sub(" ","") {print $1 "  " $2}'; )"
    echo ""
    echo "IP addresses:"
    echo "$(ifconfig $(nvram get lan_ifname)|awk 'sub("inet addr:","") {print "Configured LAN: " $1}';)"

    if [ $(nvram get wan_proto) = pppoe ] ; then
	if [ "'ifconfig | grep ppp0'" ]; then
	    echo $(ifconfig ppp0 | awk 'sub("inet addr:","") {print "Configured WAN: " $1}')
	else echo "ppp0 interface not up"
        fi
    else
    	echo $(ifconfig $(nvram get wan_ifname)|awk 'sub("inet addr:","") {print "Configured WAN: " $1}')
    fi
    echo "Effective WAN: $(wget -O - http://checkip.sipwerk.com|sed s/[^0-9.]//g)"

    echo ""
    echo "SER Uptime:"
    echo "$(openserctl fifo uptime)"
    echo ""
