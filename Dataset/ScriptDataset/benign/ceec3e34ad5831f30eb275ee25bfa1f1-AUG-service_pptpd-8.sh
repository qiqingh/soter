   # wait_till_end_state will wait a reasonable amount of time waiting for ${SERVICE_NAME}
   # to finish transitional states (stopping | starting)
   wait_till_end_state ${SERVICE_NAME}

   STATUS=`sysevent get ${SERVICE_NAME}-status`
   if [ "stopped" != "$STATUS" ] ; then
      sysevent set ${SERVICE_NAME}-errinfo 
      sysevent set ${SERVICE_NAME}-status stopping
      killall -9 pptpd
      rmmod ppp_mppe
      USE_NETBIOS="`syscfg get pptpd::use_netbios`"
# 			if [ "$USE_NETBIOS" == "1" ] ; then
# 				brctl delif br0 ppp0
# 			fi
      check_err $? "Couldnt handle stop"
      sysevent set ${SERVICE_NAME}-status stopped
   fi
#   if [ -f "/tmp/www/VPNconf.cgi" ] ; then
# 		rm -rf /tmp/www/VPNconf.cgi
# 	fi
