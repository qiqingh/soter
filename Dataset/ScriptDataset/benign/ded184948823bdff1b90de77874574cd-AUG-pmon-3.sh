    if [ "" = "$1" ] ; then
        echo "pmon-register: invalid parameter [$1]" > /dev/console
        return 1
    fi
    COUNT=`sysevent get pmon_feature_count`
    if [ "" = "$COUNT" ] ; then
        COUNT=0
    fi
    FREE_SLOT=0
    for ct in `seq 1 $COUNT`
    do
        FEATURE=`sysevent get pmon_feature_$ct`
        if [ "" = "$FEATURE" ] ; then
            FREE_SLOT=$ct
        else
            if [ "$FEATURE" = "$1" ] ; then
                return
            fi
        fi
    done
    if [ "0" != "$FREE_SLOT" ]; then
        SLOT=$FREE_SLOT
    else
        COUNT=`expr $COUNT + 1`
        SLOT=$COUNT
        sysevent set pmon_feature_count $COUNT
    fi
    sysevent set pmon_feature_$SLOT "$1"
