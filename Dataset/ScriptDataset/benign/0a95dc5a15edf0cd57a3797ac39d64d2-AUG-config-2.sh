    case ${1} in
        enable|high )
            val=1
            
            # opposite
            if [ "${3}" = "-o" ]; then
                val=0
            fi
            
            gpio export ${2}
            gpio dir ${2} out
            gpio val ${2} ${val}
            ;;
            
        disable|low )
            val=0
            
            # opposite
            if [ "${3}" = "-o" ]; then
                val=1
            fi
            
            gpio export ${2}
            gpio dir ${2} out
            gpio val ${2} ${val}
            ;;
        
        reset )
            HV=1
            LV=0
            
            # opposite
            if [ "${3}" = "-o" ]; then
                HV=0
                LV=1
            fi
            
            gpio export ${2}
            gpio dir ${2} out
            gpio val ${2} ${HV}
            gpio val ${2} ${LV}
            gpio val ${2} ${HV}
            ;;
        
        status )
            gpio export ${2}
            gpio dir ${2} out
            
            val=$(cat ${gpio_path}gpio${2}/value)
            
            if [ "${3}" = "-o" ]; then
                val=$(( (${val} + 1) % 2 ))
                set -- ${2} "${@:4}"
            fi
            
            HS=${4}
            LS=${5}
            
            if [ "${val}" = "1" ]; then
                echo ${HS:=Enable}
            else
                echo ${LS:=Disable}
            fi
            ;;
        
        export )
            if [ ! -d ${gpio_path}gpio${2} ]; then
                echo ${2} > ${gpio_path}export
            fi
            ;;
        
        dir )
            if [ -f ${gpio_path}gpio${2}/direction ]; then
                echo ${3} > ${gpio_path}gpio${2}/direction
            fi
            ;;
        
        val )
            if [ -f ${gpio_path}gpio${2}/value ]; then
                echo ${3} > ${gpio_path}gpio${2}/value
            fi
            ;;
        
        # export|dir|val|* )
            # ${cli_path}gpio.sh ${@}
            # ;;
    esac
