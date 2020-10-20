   echo -n > $1
   echo "#!/bin/sh" >> $1
   echo "TEST=\`sysevent get ntpclient-status\`" >> $1
   echo "if [ \"started\" = \"\$TEST\" ] ; then" >> $1
   echo "   sysevent set dhcp_slow_start_quanta" >> $1
   echo "   sysevent set dhcp_server-restart" >> $1
   echo "   rm -f $1" >> $1
   echo "   exit" >> $1
   echo "fi" >> $1
   echo "DHCP_SLOW_START_QUANTA=\`sysevent get dhcp_slow_start_quanta\`" >> $1
   echo "if [ -z \"\$DHCP_SLOW_START_QUANTA\" ] ; then" >> $1
   echo "   rm -f $1" >> $1
   echo "   exit" >> $1
   echo "fi" >> $1
   echo "if [ \"\$DHCP_SLOW_START_QUANTA\" -lt \"$SLOW_START_NUM_TRIES_1\" ] ; then" >> $1
   echo "   VAL=\`expr \$DHCP_SLOW_START_QUANTA + 1\`" >> $1
   echo "   sysevent set dhcp_slow_start_quanta \$VAL" >> $1
   echo "   exit" >> $1
   echo "fi" >> $1
   echo "if [ \"\$DHCP_SLOW_START_QUANTA\" -eq \"$SLOW_START_NUM_TRIES_1\" ] ; then" >> $1
   echo "   rm -f $1" >> $1
   echo "   sysevent set dhcp_server-restart" >> $1
   echo "   exit" >> $1
   echo "fi" >> $1
   echo "if [ \"\$DHCP_SLOW_START_QUANTA\" -lt \"$SLOW_START_NUM_TRIES_2\" ] ; then" >> $1
   echo "   VAL=\`expr \$DHCP_SLOW_START_QUANTA + 1\`" >> $1
   echo "   sysevent set dhcp_slow_start_quanta \$VAL" >> $1
   echo "   exit" >> $1
   echo "fi" >> $1
   echo "if [ \"\$DHCP_SLOW_START_QUANTA\" -eq \"$SLOW_START_NUM_TRIES_2\" ] ; then" >> $1
   echo "   rm -f $1" >> $1
   echo "   sysevent set dhcp_server-restart" >> $1
   echo "   exit" >> $1
   echo "fi" >> $1
   echo "if [ \"\$DHCP_SLOW_START_QUANTA\" -lt \"$SLOW_START_NUM_TRIES_3\" ] ; then" >> $1
   echo "   VAL=\`expr \$DHCP_SLOW_START_QUANTA + 1\`" >> $1
   echo "   sysevent set dhcp_slow_start_quanta \$VAL" >> $1
   echo "   exit" >> $1
   echo "fi" >> $1
   echo "   rm -f $1" >> $1
   echo "   sysevent set dhcp_server-restart" >> $1
