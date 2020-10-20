   LOCAL_CONF_FILE=$1
   
   cat << EOM > $LOCAL_CONF_FILE
USERNAME=$SYSCFG_ddns_username
PASSWORD=$SYSCFG_ddns_password
HOSTNAME=$SYSCFG_ddns_hostname
EOM
