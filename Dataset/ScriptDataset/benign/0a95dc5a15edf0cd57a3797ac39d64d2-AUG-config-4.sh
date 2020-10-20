    case $(echo ${1} | tr '[a-z]' '[A-Z]') in
        YES|Y )
            return 0
            ;;
    esac
    
    return 1
