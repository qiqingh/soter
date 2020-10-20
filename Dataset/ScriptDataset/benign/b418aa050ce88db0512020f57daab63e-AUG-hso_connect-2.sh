	echo "Bringing interface down..."
	ifconfig $NETDEV down

	echo "Disconnecting..."

	# make the disconnect script
	rm -f $SCRIPTFILE
	echo "TIMEOUT 10" >> $SCRIPTFILE
	echo "ABORT ERROR" >> $SCRIPTFILE
	echo "\"\" ATZ" >> $SCRIPTFILE
	echo "OK \"AT_OWANCALL=1,0,0^m\"" >> $SCRIPTFILE
	echo "OK \"\"" >> $SCRIPTFILE

	#============================================================
	# run the script
	#============================================================
	/usr/sbin/chat -V -f $SCRIPTFILE <$DEVICE >$DEVICE 2> /dev/null
	if [ -f /tmp/resolv.conf.hso ]
	then
		echo "Reset nameserver..."
		mv -f /tmp/resolv.conf.hso /etc/resolv.conf
	fi
	echo "Done."
