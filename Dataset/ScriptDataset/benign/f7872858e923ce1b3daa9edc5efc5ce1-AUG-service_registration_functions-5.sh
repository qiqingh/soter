   SMU_SERVICE=$1
   for SMU_EVENT in ${1}-start ${1}-stop ${1}-restart
   do
      SMU_STR=`sysevent get ${SM_PREFIX}${1}${SM_POSTFIX}_${SMU_EVENT}`
      if [ -n "$SMU_STR" ] ; then
         SMU_ASYNC=`echo $SMU_STR | cut -f 2,3 -d ' '`
         if [ -n "$SMU_ASYNC" ] ; then
            sysevent rm_async $SMU_ASYNC
            ulog srvmgr status "Unregistered $1 from ${SMU_EVENT}"
         fi
         sysevent set ${SM_PREFIX}${1}${SM_POSTFIX}_${SMU_EVENT}
      fi
   done
   SMU_IDX=1
   SMU_STR=`sysevent get ${SM_PREFIX}${1}${SM_POSTFIX}_${SMU_IDX}`
   while [ -n "$SMU_STR" ] ; do
      SMU_EVENT=`echo $SMU_STR | cut -f 1 -d ' '`
      SMU_ASYNC=`echo $SMU_STR | cut -f 2,3 -d ' '`
      if [ -n "$SMU_ASYNC" ] ; then
         sysevent rm_async $SMU_ASYNC
         ulog srvmgr status "Unregistered $SMU_SERVICE from $SMU_EVENT"
      fi
      sysevent set ${SM_PREFIX}${1}${SM_POSTFIX}_${SMU_IDX}
      SMU_IDX=`expr $SMU_IDX + 1`
      SMU_STR=`sysevent get ${SM_PREFIX}${1}${SM_POSTFIX}_${SMU_IDX}`
   done
   sysevent set ${SMU_SERVICE}-status stopped
