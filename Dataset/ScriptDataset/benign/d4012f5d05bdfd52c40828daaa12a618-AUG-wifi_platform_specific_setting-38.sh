	PID=`ps | awk "/acs_cli/"' {print $1}'`
	kill $PID > /dev/null 2>&1
	PID=`ps | awk "/chanspecfix.sh/"' {print $1}'`
	kill $PID > /dev/null 2>&1
	nvram unset acs_ifnames
	killall -q acsd
