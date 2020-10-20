   CONF_FILE=$1
   model="`syscfg get device::model_base`"
   if [ -z $model ] ; then
       model="`syscfg get device::modelNumber`"
   fi
   if [ -z $model ] ; then
       echo "WARN: Model base was empty"
   else
       echo "Lighttpd Model Base: "$model
   fi
    if [ -f $SELF_BIN/lighttpd-rainier-conf.lua ]; then
        echo "Generating Rainier lighttpd config"
        lua $SELF_BIN/lighttpd-rainier-conf.lua > /tmp/lighttpd.conf
    else
            echo "Initializing WebUI 1.0"
            if [ -e /etc/lighttpd.conf ]; then
                IPADDR=$(ifconfig br0 | grep -o "inet addr:[0-9\.]*" | grep -o "\([0-9]\{1,3\}\.\)\{3\}" | sed 's/\./\\\\\./g')
                EXPRESS="s/IPLOCAL/"$IPADDR"/g"
                cat /etc/init.d/service_httpd/lighttpd.conf | sed $EXPRESS > /tmp/lighttpd-tmp
                if [ -e /www/HNAP1/index.* ]; then
                    cat /tmp/lighttpd-tmp | sed 's/HNAP_REGEX/\|HNAP/g' > /tmp/lighttpd-tmp2
                    rm -f /tmp/lighttpd-tmp
                fi
                MODEL_BASE="s/#MODEL_BASE#/"$model"/g"
                cat /tmp/lighttpd-tmp2 | sed $MODEL_BASE > /tmp/lighttpd.conf
                rm -f /tmp/lighttpd-tmp2
            fi
    fi
