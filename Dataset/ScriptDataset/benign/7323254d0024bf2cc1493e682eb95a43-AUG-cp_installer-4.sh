    # get the URL scheme (http or https)
    SCHEME=`echo ${REPO_URL} | cut -d ':' -f1`
    # if no scheme in the URL, prepend "https://"
    if [ "${SCHEME}" != "http" ] && [ "${SCHEME}" != "https" ]; then
        REPO_URL="https://${REPO_URL}"
        SCHEME=https
    fi
    if [ "${SCHEME}" != "http" ]; then
        if [ "${CA_FILE}" != "" ]; then
            CERTIFICATE=${CA_FILE}
            if [ "${CERTIFICATE}" = "" ]; then
                CERTIFICATE=/etc/ca/CAs.txt
            fi
        fi
        HTTPS_FLAGS="--secure-protocol=auto  --ca-certificate=${CERTIFICATE}"
    fi
