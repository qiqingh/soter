   USERNAME=$1
   PASSWORD=$2
   IS_ENCODED=$3
   if [ "" = "$USERNAME" ] || [ "" = "$PASSWORD" ] ; then
      return
   fi
   sysevent set fuadmin_pass "$PASSWORD"
   if [ "encoded" = "$IS_ENCODED" ] ; then
       if [ -f $PASSWORD_FILE ] ; then
	   if grep "$USERNAME" $PASSWORD_FILE > /dev/null 2>&1 ; then
	       sed 's/^\('${USERNAME}':\)\(.*\)$/\1'${PASSWORD}'/g' < $PASSWORD_FILE > .htpasswd.NEW && mv .htpasswd.NEW $PASSWORD_FILE 
	   else
	       echo "$USERNAME:$PASSWORD" >> $PASSWORD_FILE
	   fi
       else
	   echo "$USERNAME:$PASSWORD" >> $PASSWORD_FILE
       fi
   else
      if [ -f $PASSWORD_FILE ] ; then
          echo "$PASSWORD" | /usr/sbin/htpasswd $PASSWORD_FILE $USERNAME > /dev/null 2>&1
      else 
          echo "$PASSWORD" | /usr/sbin/htpasswd -c $PASSWORD_FILE $USERNAME > /dev/null 2>&1
      fi
   fi
   grep $USERNAME $PASSWORD_FILE | cut -f2 -d:
