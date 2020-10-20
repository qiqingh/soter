#!/bin/sh

. /lib/functions/system.sh
. /usr/share/libubox/jshn.sh
. /lib/hummer/api.sh

PATH_24G=`cat /etc/wireless/l1profile.dat | grep INDEX0_profile_path | cut -d '=' -f 2`
PATH_5G=`cat /etc/wireless/l1profile.dat | grep INDEX1_profile_path | cut -d '=' -f 2`

PATH_SKU_24G=`cat /etc/wireless/l1profile.dat | grep INDEX0_single_sku_path | cut -d '=' -f 2`
PATH_SKU_5G=`cat /etc/wireless/l1profile.dat | grep INDEX1_single_sku_path | cut -d '=' -f 2`

PATH_BF_24G=`cat /etc/wireless/l1profile.dat | grep INDEX0_bf_sku_path | cut -d '=' -f 2`
PATH_BF_5G=`cat /etc/wireless/l1profile.dat | grep INDEX1_bf_sku_path | cut -d '=' -f 2`




case "$1" in
    show)
        show_mpt_info
        ;;
    set_sku)
        case "$2" in
            US|AH|CN|KR|CA)

                gcontrol di set cert_region $2
                gcontrol di commit
                echo "system is reset to default..."
                
				#system_reset
				rm -f /tmp/gdata/conf.dat
				rm -rf /overlay/*
				reboot -d 3
                ;;
            *)
                echo "Wrong SKU option!"
                ;;
        esac
        ;;
	set_country)
        SKU=`gcontrol di get cert_region | cut -d"=" -f 2`
        if [ "$SKU" = "AH" ]; then

            objReq wlanMpt setparam selectedCountry $2
			wireless.sh update_mpt
            
			wifi down
			wifi up
			
		elif [ "$SKU" = "US" ]; then
		
            objReq wlanMpt setparam selectedCountry USA
			wireless.sh update_mpt
			
			wifi down
			wifi up
        else
            echo "Could not set country with the $SKU SKU!"
        fi
        ;;	
    *) usage;;
esac
