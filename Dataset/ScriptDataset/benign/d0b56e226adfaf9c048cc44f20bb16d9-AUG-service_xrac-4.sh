   cat << EOF > $CRON_FILE
#!/bin/sh
$0 service_check
EOF
   chmod +x $CRON_FILE
