    local mac
    local match
    mac=$1
    ADDR_IPV4=""
    if [ -f $DHCP_LEASEFILE ]
    then
        match=`grep -i $mac $DHCP_LEASEFILE`
        if [ "$?" -eq 0 ]
        then
            ADDR_IPV4=`echo $match | awk '{print $3}'`
            return
        fi
    fi
    if [ -f $STATICIP_HOSTS ]
    then
        match=`grep -i $mac $STATICIP_HOSTS`
        if [ "$?" -eq 0 ]
        then
            ADDR_IPV4=`echo $match | awk '{print $2}'`
            return
        fi
    fi
    if [ -f $DETECTED_HOSTS ]
    then
        match=`grep -i $mac $DETECTED_HOSTS`
        if [ "$?" -eq 0 ]
        then
            ADDR_IPV4=`echo $match | awk '{print $3}'`
            return
        fi
    fi
