   if [ -z "$3" ] ; then
      return
   fi
   sysevent set ${1}_ipv6_deprecated_but_valid_delegated_address_lifetime $3
   CRON_TIMEOUT_FILE="${CRON_TIMEOUT_DIR}${1}_deprecated_prefix_timeout.sh"
   echo "#!/bin/sh" > $CRON_TIMEOUT_FILE
   echo "INTERFACE_NAME=$1" >> $CRON_TIMEOUT_FILE
   echo "DEPR_ADDR=$2" >> $CRON_TIMEOUT_FILE
   echo "SELF_FILE=$CRON_TIMEOUT_FILE" >> $CRON_TIMEOUT_FILE
   echo "MINS_LEFT=\`sysevent get ${1}_ipv6_deprecated_but_valid_delegated_address_lifetime\`" >> $CRON_TIMEOUT_FILE
   echo "if [ -z \"\$MINS_LEFT\" ] ; then" >> $CRON_TIMEOUT_FILE
   echo "   MINS_LEFT=1" >> $CRON_TIMEOUT_FILE
   echo "fi" >> $CRON_TIMEOUT_FILE
   echo "MINS_LEFT=\`expr \$MINS_LEFT - 1\`" >> $CRON_TIMEOUT_FILE
   echo "if [ \"\$MINS_LEFT\" -gt \"0\" ] ; then"  >> $CRON_TIMEOUT_FILE
   echo "   sysevent set ${1}_ipv6_deprecated_but_valid_delegated_address_lifetime \$MINS_LEFT"  >> $CRON_TIMEOUT_FILE
   echo "   return" >> $CRON_TIMEOUT_FILE
   echo "else" >> $CRON_TIMEOUT_FILE
   echo "   sysevent set dhcpv6_client_expire_deprecated_address \"\$INTERFACE_NAME \$DEPR_ADDR\"" >> $CRON_TIMEOUT_FILE
   echo "   sysevent set ${1}_ipv6_deprecated_but_valid_delegated_address_lifetime " >> $CRON_TIMEOUT_FILE
   echo "   rm -f \$SELF_FILE" >> $CRON_TIMEOUT_FILE
   echo "fi" >> $CRON_TIMEOUT_FILE
   chmod 777 $CRON_TIMEOUT_FILE
