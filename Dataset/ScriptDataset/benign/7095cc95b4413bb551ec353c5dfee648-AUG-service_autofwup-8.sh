	BOOTPART=`syscfg get fwup_boot_part`
	CONFIGDIR="/tmp/var/config"
	LICENSEDIR="${CONFIGDIR}/license"
	mkdir -p ${LICENSEDIR}
	PRIMARYLICENSE=
	if [ -e "${LICENSEDIR}/primary" ]; then
		PRIMARYLICENSE=`cat ${LICENSEDIR}/primary`
	fi
	ALTERNATELICENSE=
	if [ -e "${LICENSEDIR}/alternate" ]; then
		PRIMARYLICENSE=`cat ${LICENSEDIR}/alternate`
	fi
	
	HOWMANYLICENSEDOC=`ls ${LICENSEDIR}/*.gz -1 | wc -l`
	if [ $HOWMANYLICENSEDOC -gt 2 ] 
	then
		mkdir -p /tmp/templicense
		if [ ! -z ${PRIMARYLICENSE} ] && [ -e "${LICENSEDIR}/${PRIMARYLICENSE}.gz" ]
		then
			cp -f ${LICENSEDIR}/${PRIMARYLICENSE}.gz /tmp/templicense/.
		fi
		if [ ! -z ${ALTERNATELICENSE} ] && [ -e "${LICENSEDIR}/${ALTERNATELICENSE}.gz" ]
		then
			cp -f ${LICENSEDIR}/${ALTERNATELICENSE}.gz /tmp/templicense/.
		fi
		if [ -e "${LICENSEDIR}/fw_license.pdf.gz" ]
		then
			cp -f ${LICENSEDIR}/fw_license.pdf.gz /tmp/templicense/.
		fi
		if [ -e "${LICENSEDIR}/primary" ]
		then
			cp -f ${LICENSEDIR}/primary /tmp/templicense/.
		fi
		if [ -e "${LICENSEDIR}/alternate" ]
		then
			cp -f ${LICENSEDIR}/alternate /tmp/templicense/.
		fi
		rm -f ${LICENSEDIR}/*.gz
		mv -f /tmp/templicense/* ${LICENSEDIR}/.
	fi
	if [ ! -z $1 ]
	then
		LICENSE_FILE=`echo "$1" | cut -f3 -d'/'`
		if [ "${BOOTPART}" = "1" ]
		then
			if [ ! -z ${ALTERNATELICENSE} ] && [ -e "${LICENSEDIR}/${ALTERNATELICENSE}.gz" ]
			then
				rm -f ${LICENSEDIR}/${ALTERNATELICENSE}.gz
			fi
			echo "${LICENSE_FILE}" > ${LICENSEDIR}/alternate
		else
			if [ ! -z ${PRIMARYLICENSE} ] && [ -e "${LICENSEDIR}/${PRIMARYLICENSE}.gz" ]
			then
				rm -f ${LICENSEDIR}/${PRIMARYLICENSE}.gz
			fi
			echo "${LICENSE_FILE}" > ${LICENSEDIR}/primary
		fi
		gzip -cf $1 > ${LICENSEDIR}/$LICENSE_FILE.gz
	else
		if [ "${BOOTPART}" = "1" ]
		then
			if [ ! -z ${ALTERNATELICENSE} ] && [ -e "${LICENSEDIR}/${ALTERNATELICENSE}.gz" ]
			then
				rm -f ${LICENSEDIR}/${ALTERNATELICENSE}.gz
			fi
			rm -f ${LICENSEDIR}/alternate
		else
			if [ ! -z ${PRIMARYLICENSE} ] && [ -e "${LICENSEDIR}/${PRIMARYLICENSE}.gz" ]
			then
				rm -f ${LICENSEDIR}/${PRIMARYLICENSE}.gz
			fi
			rm -f ${LICENSEDIR}/primary
		fi
	fi
	touch ${CONFIGDIR}/updated
