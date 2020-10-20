
    log_info "wps" "stop wps process"

    iwpriv rai0 set WscStop=1
    iwpriv ra0 set WscStop=1

    /usr/bin/ledstatus.sh wps_finish
    rm -f $RUNNING
    exit 1
