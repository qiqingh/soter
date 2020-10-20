    NUMSIZE=5
    substring=""
    normalized_string=""

    startnum=-1
    chars=`echo ${1} | awk -v ORS="" '{ gsub(/./,"&\n") ; print }'`
    for char in $chars; do 
        case $char in
            "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | "0")
                substring="${substring}${char}"
                ;;
            *)
                if [ ${#substring} -gt 0 ]; then
                    pack_accum=${#substring}
                    while [ ${pack_accum} -lt ${NUMSIZE} ]; do
                        #pack_accum=$((${pack_accum}+1))
                        pack_accum=`expr ${pack_accum} + 1`
                        normalized_string="${normalized_string}0"
                    done
                    normalized_string="${normalized_string}${substring}"
                    substring=""
                fi
                normalized_string="${normalized_string}${char}"
                ;;
        esac
    done

    if [ ${#substring} -gt 0 ]; then
        pack_accum=${#substring}
        while [ ${pack_accum} -lt ${NUMSIZE} ]; do
            #pack_accum=$((${pack_accum}+1))
            pack_accum=`expr ${pack_accum} + 1`
            normalized_string="${normalized_string}0"
        done
        normalized_string="${normalized_string}${substring}"
    fi
