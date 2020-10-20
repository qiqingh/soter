    if [ "" = "$1" ] ; then
        return 1
    fi
    COUNT=`sysevent get pmon_feature_count`
    if [ "" = "$COUNT" ] ; then
        COUNT=0
    fi
    for ct in `seq 1 $COUNT`
    do
        FEATURE=`sysevent get pmon_feature_$ct`
        if [ "" != "$FEATURE" ] && [ "$1" = "$FEATURE" ] ; then
            sysevent set pmon_feature_$ct 
            sysevent set pmon_proc_$feature 
            return
        fi
    done
