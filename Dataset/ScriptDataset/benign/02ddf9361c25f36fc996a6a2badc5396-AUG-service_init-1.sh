   PASSWD=`syscfg get http_admin_password`
   if [ -z "$PASSWD" ] ; then
      return
   fi
   echo "root:$PASSWD" | chpasswd -e
