   echo "#! /bin/sh" > $RETRY_SOON_FILENAME;
   if [ "started" = "`sysevent get ${SERVICE_NAME}-status`" ] ; then
      echo "   sysevent set ntpclient-check" >> $RETRY_SOON_FILENAME;
   else
      echo "   sysevent set ntpclient-start" >> $RETRY_SOON_FILENAME;
   fi
   chmod 700 $RETRY_SOON_FILENAME;
