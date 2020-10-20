   echo -n > $BP_CONNECTED_SCRIPT
cat << EOM >> $BP_CONNECTED_SCRIPT
#!/bin/sh
source /etc/init.d/ulog_functions.sh
echo "[utopia][bpalogin connected]" > /dev/console
sysevent set ppp_status up 2>&1 > /dev/console
ulog bp-up event "sysevent set ppp_status up"
echo "[utopia][bpalogin connected] sysevent set ppp_status up <\`date\`>" > /dev/console
EOM
   chmod 777 $BP_CONNECTED_SCRIPT
