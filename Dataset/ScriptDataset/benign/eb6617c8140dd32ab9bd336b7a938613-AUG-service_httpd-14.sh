    retVal=0
    LAN_STATUS=`sysevent get lan-status`
    if [ "started" == "$LAN_STATUS" ] ; then
        retVal=0
    else
        retVal=1
    fi
    return $retVal
