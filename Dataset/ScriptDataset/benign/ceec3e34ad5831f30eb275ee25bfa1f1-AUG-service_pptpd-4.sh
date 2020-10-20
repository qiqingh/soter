	mkdir -p `dirname "$OPTS_FILE"`
	MDNS_IP="`syscfg get pptpd::mdnsip`"
	if [ ! "$MDNS_IP" ] ; then
		MDNS_IP="$dfc_mdnsip"
		echo "$SERVICE_NAME using default mdnsip $MDNS_IP"
		syscfg set pptpd::mdnsip "$MDNS_IP"
	fi
	CFG_DEBUG="`syscfg get pptpd::debug`"
	if [ ! "$CFG_DEBUG" ] ; then
		CFG_DEBUG="$dfc_debug"
		syscfg set pptpd::debug "$CFG_DEBUG"
	fi
	echo ""  > $OPTS_FILE
	echo "lock" >> $OPTS_FILE
	if [ "`syscfg get pptpd::debug`" == "1" ] ; then
		echo "debug" >> $OPTS_FILE
	fi
	echo "name PPTPD" >> $OPTS_FILE
	# echo "remotename PPTPD" >> $OPTS_FILE
	echo "proxyarp" >> $OPTS_FILE
	echo "asyncmap 0" >> $OPTS_FILE
	echo "-chap" >> $OPTS_FILE
	echo "-mschap" >> $OPTS_FILE
	echo "+mschap-v2" >> $OPTS_FILE
	USE_MPPE="`syscfg get pptpd::use_mppe`"
	if [ ! "$USE_MPPE" ] ; then
		USE_MPPE="$dfc_use_mppe"
		syscfg set pptpd::use_mppe "$USE_MPPE"
	fi
	if [ "$USE_MPPE" == "1" ] ; then
		echo "require-mppe-128" >> $OPTS_FILE
		# echo "require-mppe" >> $OPTS_FILE
	fi
	echo "lcp-echo-failure 30" >> $OPTS_FILE
	echo "lcp-echo-interval 5" >> $OPTS_FILE
	echo "ipcp-accept-local" >> $OPTS_FILE
	echo "ipcp-accept-remote" >> $OPTS_FILE
# 	echo "" >> $OPTS_FILE
# 	echo "" >> $OPTS_FILE
#	echo "$SERVICE_NAME opts file created" >> /dev/console
