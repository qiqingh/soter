    ulog ${SERVICE_NAME} status "downloading devregex"
    if [ ! -z "$SYSCFG_devidentd_download_devregex_url" ] ; then
        curl -L $SYSCFG_devidentd_download_devregex_url --create-dirs -o $DEVREGEX_TMP_FILE --capath $CERTS_ROOT
    else
        curl -L $DEVREGEX_URL --create-dirs -o $DEVREGEX_TMP_FILE --capath $CERTS_ROOT
    fi
    if [ ! -d $DEVREGEX_FILE_DIR ] ; then
        mkdir -p $DEVREGEX_FILE_DIR
    fi
    /sbin/devidentd_lock "mv $DEVREGEX_TMP_FILE $DEVREGEX_FILE"
    clear_all
