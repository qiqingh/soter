   echo -n > $BP_DISCONNECTED_SCRIPT
cat << EOM >> $BP_DISCONNECTED_SCRIPT
#!/bin/sh
source /etc/init.d/ulog_functions.sh
echo "[utopia][bpalogin connected]" > /dev/console
sysevent set ppp_status down 2>&1 > /dev/console
ulog bp-down event "sysevent set ppp_status down"
echo "[utopia][bpalogin connected] sysevent set ppp_status down <\`date\`>" > /dev/console
EOM
   chmod 777 $BP_DISCONNECTED_SCRIPT
