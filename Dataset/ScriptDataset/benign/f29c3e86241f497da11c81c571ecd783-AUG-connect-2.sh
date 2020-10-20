	echo disconnecting

	/usr/sbin/chat -V -f /etc/hso/stop.cht <$DEVICE >$DEVICE
	ifconfig hso0 down
	echo "reset nameserver"
	mv -f /tmp/resolv.conf.tmp /etc/resolv.conf
