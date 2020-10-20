    /etc/init.d/service_devidentd/deviceupdate.lua
    if [ "$?" -ne "0" ] ; then
        ulog_error ${SERVICE_NAME} status "failed to update local device with error $?"
    fi
