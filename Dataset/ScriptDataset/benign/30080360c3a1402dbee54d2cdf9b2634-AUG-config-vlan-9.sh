    vlan_tag=$1
    result=""
    while [ $vlan_tag -gt 0 ]; do
        rem_val=`expr $vlan_tag % 16`
        vlan_tag=`expr $vlan_tag / 16`
        case $rem_val in
            15)
                hex_digits='f'
                ;;
            14)
                hex_digits='e'
                ;;
            13)
                hex_digits='d'
                ;;
            12)
                hex_digits='c'
                ;;
            11)
                hex_digits='b'
                ;;
            10)
                hex_digits='a'
                ;;
            *)
                hex_digits="$rem_val"
                ;;
        esac
        result="${hex_digits}${result}"
    done
    if [ ${#result} = 1 ]; then
        result="00${result}"
    elif [ ${#result} = 2 ]; then
        result="0${result}"
    fi
    VID_HEX=${result}
