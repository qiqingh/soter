    get_https_flags
    get_update_version
    RESULT=${?}
    if [ $RESULT -ne 0 ]; then
        echo "        -- revert to installed cpinst!"
        return 0
    fi

    #   fetch the cp startup scripts from the repository
    DONE=0
    while [ $DONE -eq 0 ]; do
        # delete partially downloaded file just in case
        rm -f /tmp/cpinst.tar.gz

	cp_timing_debug "${0} install_cpinst wget === > > >"
        wget -4 ${HTTPS_FLAGS} ${REPO_URL}/${TARGET_ID}/pkg_cont-${UPDATE_FIRMWARE_VERSION}/packages/cpinst.tar.gz -O /tmp/cpinst.tar.gz
        RESULT=${?}
	cp_timing_debug "install_cpinst wget < < < ==="
        if [ ${RESULT} -ne 0 ]; then 
            echo "        -- Unable to connect to package server. ... retrying in 1 minute ${0}"
            sleep 60
        else
            DONE=1
        fi
    done

    tar -zxf /tmp/cpinst.tar.gz
    rm -rf ./META-INF
    rm -rf /tmp/cpinst.tar.gz
