   if [ ! -f "$DHCP_LEASE_FILE" ] ; then
      return
   fi
   SLF_OUTFILE_1="/tmp/sanitize_leases.${$}"
   if [ -z "$SYSCFG_dhcp_num" ] || [ "0" = "$SYSCFG_dhcp_num" ] ; then
      echo > $DHCP_LEASE_FILE
      return
   fi
   cat $DHCP_LEASE_FILE  > $SLF_OUTFILE_1
   while read line ; do
      CANDIDATE_IP=`echo $line | cut -f 3 -d ' '`
      if [ -n "$CANDIDATE_IP" ] ; then
         is_network_conflict $SYSEVENT_lan_ipaddr $SYSEVENT_lan_prefix_len $CANDIDATE_IP $SYSEVENT_lan_prefix_len
         if [ "0" = "$?" ] ; then
            delete_dhcp_lease $CANDIDATE_IP
         fi
      fi
   done < $SLF_OUTFILE_1
   rm -f $SLF_OUTFILE_1
