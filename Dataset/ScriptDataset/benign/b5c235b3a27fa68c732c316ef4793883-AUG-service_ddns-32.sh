    if [ ! -d $DDNS_TMP_DIR ]; then
       mkdir $DDNS_TMP_DIR
    fi
    FOO=`utctx_cmd get ddns_enable ddns_update_days ddns_hostname ddns_username ddns_password ddns_service ddns_mx ddns_mx_backup ddns_wildcard ddns_server ddns_failure_time`
    eval $FOO
