   define_lighttpd_env
   echo "" > $CONF_FILE
   append_lighttpd_common_conf $CONF_FILE
   if [ -f /www/lsdp/index.fcgi ]; then
   	append_lighttpd_lsdp_conf $CONF_FILE
   fi
   if [ -f /www/association/association.fcgi ]; then
   	append_lighttpd_setupldal_conf $CONF_FILE
   fi
	CONFIGDIR="/tmp/var/config"
	LICENSEDIR="${CONFIGDIR}/license"
	OLDLICENSEDIR="${CONFIGDIR}/licenses"
	BOOTPART=`syscfg get fwup_boot_part`
	DEFAULTLICENSE="FW_LICENSE_default.pdf.gz"
	
	if [ -e "${OLDLICENSEDIR}" ]; then
		rm -rf ${OLDLICENSEDIR}
	fi
	if [ ! -e "${LICENSEDIR}" ]; then
		echo "Creating ${LICENSEDIR}"
		mkdir -p ${LICENSEDIR}
	fi
	if [ -e "${LICENSEDIR}/primary" ]; then
		PRIMARYLICENSE=`cat ${LICENSEDIR}/primary`
	else
		PRIMARYLICENSE=
	fi
	if [ -e "${LICENSEDIR}/alternate" ]; then
		ALTERNATELICENSE=`cat ${LICENSEDIR}/alternate`
	else
		ALTERNATELICENSE=
	fi
	syscfg unset license_url
	if [ "${BOOTPART}" = "1" ]
	then
		if [ -z ${PRIMARYLICENSE} ]
	    then
			cp /etc/${DEFAULTLICENSE} ${LICENSEDIR}/fw_license.pdf.gz
	    elif [ -e "${LICENSEDIR}/${PRIMARYLICENSE}.gz" ]
	    then
			syscfg set license_url ${PRIMARYLICENSE}.gz
	    fi
	else
		if [ -z ${ALTERNATELICENSE} ]
		then
			cp /etc/${DEFAULTLICENSE} ${LICENSEDIR}/fw_license.pdf.gz
		elif [ -e "${LICENSEDIR}/${ALTERNATELICENSE}.gz" ]
		then
			syscfg set license_url ${ALTERNATELICENSE}.gz
		fi
	fi
   wwwconf="`syscfg get www_conf_dir`";
   if [ ! -z wwwconf ]; then 
   	echo "Build temporary www configuration directory: "$wwwconf
	if [ ! -e $wwwconf ]; then
		mkdir -p $wwwconf
		ln -s $wwwconf /www/conf
   	fi
   fi
