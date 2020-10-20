	rm -f /tmp/gdata/conf.dat
	rm -rf /overlay/*
	if [ -z $1 ]; then
		reboot -d 3
	else
		reboot
	fi
