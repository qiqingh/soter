	ulog autofwup status "update_firmware_now event : ${UPDATEMODE}, ${ALTSERVERURL}"
	pidof fwupd > /dev/null
	if [ $? != "0" ] 
	then
		UPDATEMODE=`sysevent get update_firmware_now`
		sysevent set update_firmware_now    
		ALTSERVERURL=`syscfg get fwup_altserver_uri`
		syscfg unset fwup_altserver_uri
		if [ "${UPDATEMODE}" = "1"  -o "${UPDATEMODE}" = "2" ]
		then
			if [ ! -z "${ALTSERVERURL}" ]
			then
				fwupd -m ${UPDATEMODE} -u ${ALTSERVERURL} &
			else
				fwupd -m ${UPDATEMODE} &
			fi
		fi
	fi		
