    PACKAGE_DB=${CP_INSTALL_DIR}/"pkgdb"
    PKG_LIST=${PACKAGE_DB}/"pkg_list"

    if [ ! -f ${PKG_LIST} ]; then 
        echo "  -- ${PKG_LIST} not found"
        return 1
    fi
    #   iterate through the packages in the pkg_list file
    while read line; do
        PKG_NAME=`echo ${line} | cut -d " " -f1`
        PKG_STATE_FILE=${PACKAGE_DB}/${PKG_NAME}/"state"
        if [ ! -f ${PKG_STATE_FILE} ]; then 
            echo "      -- ${PKG_STATE_FILE} not found"
            return 1
        fi
        PKG_STATE=`cat ${PKG_STATE_FILE}`
        echo "  -- ${PKG_STATE_FILE} = ${PKG_STATE}"
        if [ ${PKG_STATE} != "validated" ]; then
            return 1
        fi
    done < ${PKG_LIST}
    # All packages validated OK
    return 0
