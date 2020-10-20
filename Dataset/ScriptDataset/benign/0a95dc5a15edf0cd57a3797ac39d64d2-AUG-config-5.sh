    for pid in $(ps | grep -v grep | grep "${1}" | awk '{print $1}'); do
        # only the XML CLI command have configure the interrupt="true" attribute can be use -INT
        kill -INT ${pid}
    done
