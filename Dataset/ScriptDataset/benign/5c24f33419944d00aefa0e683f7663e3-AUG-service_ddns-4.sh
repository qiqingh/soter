   LOCAL_CONF_FILE=$1
   
   MODEL=`syscfg get device::modelNumber`
   HW_REV=`syscfg get device::hw_revision`
   FW_VERSION=`syscfg get fwup_firmware_version`
   
   cat << EOM > $LOCAL_CONF_FILE
PARTNER=linksys
AGENT=${MODEL}, Rev${HW_REV}/${FW_VERSION}
KEY=$SYSCFG_ddns_password
DOMAIN=$SYSCFG_ddns_hostname
EMAIL=$SYSCFG_ddns_username
PORT=80
IPFILE=$TZO_CACHE
EOM
