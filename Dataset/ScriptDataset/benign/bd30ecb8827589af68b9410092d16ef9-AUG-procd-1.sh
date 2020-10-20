	local basescript=$(readlink "$initscript")
	local service_name="$(basename ${basescript:-$initscript})"

	flock -n 1000 &> /dev/null
	if [ "$?" != "0" ]; then
		exec 1000>"$IPKG_INSTROOT/var/lock/procd_${service_name}.lock"
		flock 1000
		if [ "$?" != "0" ]; then
			logger "warning: procd flock for $service_name failed"
		fi
	fi
