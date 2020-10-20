   NAME=`sysevent get ${SELF_NAME}_gp_fw_1`
   if [ -n "$NAME" ] ; then
      sysevent set $NAME
      sysevent set ${SELF_NAME}_gp_fw_1
   fi
   NAME=`sysevent get ${SELF_NAME}_gp_fw_2`
   if [ -n "$NAME" ] ; then
      sysevent set $NAME
      sysevent set ${SELF_NAME}_gp_fw_2
   fi
   NAME=`sysevent get ${SELF_NAME}_gp_fw_3`
   if [ -n "$NAME" ] ; then
      sysevent set $NAME
      sysevent set ${SELF_NAME}_gp_fw_3
   fi
   NAME=`sysevent get ${SELF_NAME}_nat_fw_1`
   if [ -n "$NAME" ] ; then
      sysevent set $NAME
      sysevent set ${SELF_NAME}_nat_fw_1
   fi
   NAME=`sysevent get ${SELF_NAME}_nat_fw_2`
   if [ -n "$NAME" ] ; then
      sysevent set $NAME
      sysevent set ${SELF_NAME}_nat_fw_2
   fi
   NAME=`sysevent get ${SELF_NAME}_nat_fw_3`
   if [ -n "$NAME" ] ; then
      sysevent set $NAME
      sysevent set ${SELF_NAME}_nat_fw_3
   fi
