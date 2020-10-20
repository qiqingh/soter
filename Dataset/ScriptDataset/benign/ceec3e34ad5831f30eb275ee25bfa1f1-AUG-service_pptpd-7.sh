    if [ "`syscfg get pptpd::enabled`" != "1" ] ; then
        return
    fi
  # wait_till_end_state will wait a reasonable amount of time waiting for ${SERVICE_NAME}
  # to finish transitional states (stopping | starting)
  wait_till_end_state ${SERVICE_NAME}
   
  if [ "`sysevent get ${SERVICE_NAME}-delay_start`" == "" ] ; then
		# echo "delay start of pptpd VPN until settled" >> /dev/console
		sleep 15
		sysevent set ${SERVICE_NAME}-delay_start done
  fi
	service_init
	STATUS=`sysevent get ${SERVICE_NAME}-status`
	if [ "started" != "$STATUS" ] ; then
		sysevent set ${SERVICE_NAME}-errinfo 
		sysevent set ${SERVICE_NAME}-status starting
		create_conf_file
		create_opts_file
		create_auth_file
		#insmod /lib/modules/3.2.27/ppp_mppe.ko
		modprobe ppp_mppe
		/usr/local/sbin/pptpd -c $CONF_FILE -o $OPTS_FILE -d
		USE_NETBIOS="`syscfg get pptpd::use_netbios`"
		if [ ! "$USE_NETBIOS" ] ; then
			USE_NETBIOS="$dfc_use_netbios"
			syscfg set pptpd::use_netbios "$USE_NETBIOS"
		fi
		check_err $? "Couldnt handle start"
		sysevent set ${SERVICE_NAME}-status started
	fi
	
	if [ -f "/usr/local/sbin/VPNconf.cgi" ] ; then
		if [ ! -f "/tmp/www/VPNconf.cgi" ] ; then
			echo "creating dev link for VPN web configuration..."
			mkdir -p /tmp/www
			cp /usr/local/sbin/VPNconf.cgi /tmp/www/VPNconf.cgi
		fi
	fi
