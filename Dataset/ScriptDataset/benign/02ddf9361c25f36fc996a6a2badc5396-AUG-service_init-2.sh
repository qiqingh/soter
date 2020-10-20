   PASSWD=`syscfg get http_admin_password`
   if [ -z "$PASSWD" ] ; then
      return
   fi
   echo "admin:$PASSWD" | chpasswd -e
