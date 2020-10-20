   TMP_PASSWORD_FILE=/tmp/.tmp_htpasswd_$$
   USERNAME=$1
   if [ "" = "$USERNAME" ] ; then
      USERNAME=admin
   fi
   PASSWORD=$2
   if [ "" = "$PASSWORD" ] ; then
      PASSWORD=admin
   fi
   sysevent set fuadmin_pass "$PASSWORD"
   
   echo $PASSWORD | /usr/sbin/htpasswd -c $TMP_PASSWORD_FILE $USERNAME > /dev/null 2>&1
   sed -i 's/^.*://g' $TMP_PASSWORD_FILE
   cat $TMP_PASSWORD_FILE
   rm -f $TMP_PASSWORD_FILE
