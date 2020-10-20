	PHY_IF=$1
    MULTIREGION_SUPPORT=`syscfg_get wifi::multiregion_support`
    MULTIREGION_ENABLE=`syscfg_get wifi::multiregion_enable`
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
	DFS=`syscfg_get "$SYSCFG_INDEX"_dfs_enabled`
    REGION=""
    COUNTRY=""
    if [ "1" = "$MULTIREGION_SUPPORT" -a "1" = "$MULTIREGION_ENABLE" ]; then
        echo "${SERVICE_NAME}, Multi-region is supported and enabled"
        REGION=`syscfg_get wifi::multiregion_region`
        COUNTRY=`syscfg_get wifi::multiregion_selectedcountry`
        echo "${SERVICE_NAME}, Region: $REGION, Country: $COUNTRY"
    else
        echo "${SERVICE_NAME}, Multi-region is not supported or not enabled"
	    REGION=`syscfg_get device::cert_region`
        echo "${SERVICE_NAME}, Cert region: $REGION"
    fi
    if [ -z "$COUNTRY" ]; then
        if [ "US" = "$REGION" ]; then
            set_wifi_val $PHY_IF CountryCode US
            set_wifi_val $PHY_IF CountryRegion 0
            set_wifi_val $PHY_IF CountryRegionABand 10
        elif [ "CA" = "$REGION" ]; then
            set_wifi_val $PHY_IF CountryCode CA
            set_wifi_val $PHY_IF CountryRegion 0
            set_wifi_val $PHY_IF CountryRegionABand 10
        elif [ "EU" = "$REGION" ]; then
            set_wifi_val $PHY_IF CountryCode GB
            set_wifi_val $PHY_IF CountryRegion 1
	    if [ "$SYSCFG_INDEX" = "wl1" ]; then
		    if [ "$DFS" = "1" ]; then
			    set_wifi_val $PHY_IF CountryRegionABand 1
		    else
			    set_wifi_val $PHY_IF CountryRegionABand 6	
		    fi
	    fi
        elif [ "AU" = "$REGION" ]; then
            set_wifi_val $PHY_IF CountryCode AU
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 10
        elif [ "AH" = "$REGION" ]; then
            set_wifi_val $PHY_IF CountryCode TH
            set_wifi_val $PHY_IF CountryRegion 1
            if [ "$SYSCFG_INDEX" = "wl1" -a "$DFS" = "1" ]; then
                set_wifi_val $PHY_IF CountryRegionABand 7
            else
                set_wifi_val $PHY_IF CountryRegionABand 10
            fi
        elif [ "HK" = "$REGION" ]; then
            set_wifi_val $PHY_IF CountryCode CA
            set_wifi_val $PHY_IF CountryRegion 0
            set_wifi_val $PHY_IF CountryRegionABand 10
        else
            set_wifi_val $PHY_IF CountryCode US
            set_wifi_val $PHY_IF CountryRegion 0
            set_wifi_val $PHY_IF CountryRegionABand 10
        fi
    else
        if [ "CHN" = "$COUNTRY" ]; then #China
            set_wifi_val $PHY_IF CountryCode CN
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 10
        elif [ "HKG" = "$COUNTRY" ]; then #Hongkong
            set_wifi_val $PHY_IF CountryCode HK
            set_wifi_val $PHY_IF CountryRegion 0
            set_wifi_val $PHY_IF CountryRegionABand 10
        elif [ "IND" = "$COUNTRY" ]; then #India
            set_wifi_val $PHY_IF CountryCode IN
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 10
        elif [ "IDN" = "$COUNTRY" ]; then #Indonesia
            set_wifi_val $PHY_IF CountryCode TH
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 5
        elif [ "PHL" = "$COUNTRY" ]; then  #Philipine
            set_wifi_val $PHY_IF CountryCode PH
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 10
        elif [ "SGP" = "$COUNTRY" ]; then #Singapore
            set_wifi_val $PHY_IF CountryCode SG
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 10
        elif [ "THA" = "$COUNTRY" ]; then #Thailand
            set_wifi_val $PHY_IF CountryCode TH
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 10
        elif [ "XAH" = "$COUNTRY" ]; then #Rest of Asia
            set_wifi_val $PHY_IF CountryCode TH
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 10
        elif [ "AUS" = "$COUNTRY" ]; then #Australia
            set_wifi_val $PHY_IF CountryCode GB
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 6
        elif [ "CAN" = "$COUNTRY" ]; then #Canada
            set_wifi_val $PHY_IF CountryCode CA
            set_wifi_val $PHY_IF CountryRegion 0
            set_wifi_val $PHY_IF CountryRegionABand 10
        elif [ "EEE" = "$COUNTRY" ]; then #Europe
            set_wifi_val $PHY_IF CountryCode GB
            set_wifi_val $PHY_IF CountryRegion 1
	    set_wifi_val $PHY_IF CountryRegionABand 1
	elif [ "NZL" = "$COUNTRY" ]; then #New Zealand
	    set_wifi_val $PHY_IF CountryCode GB
	    set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 6
        elif [ "XME" = "$COUNTRY" ]; then #Middle East
            set_wifi_val $PHY_IF CountryCode GB
            set_wifi_val $PHY_IF CountryRegion 1
		set_wifi_val $PHY_IF CountryRegionABand 1
	elif [ "SAU" = "$COUNTRY" ]; then #Middle East- Saudi Arabia
            set_wifi_val $PHY_IF CountryCode GB
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 1
        elif [ "ARE" = "$COUNTRY" ]; then #Middle East- United Arab Emirates
            set_wifi_val $PHY_IF CountryCode GB
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 7
        elif [ "BHR" = "$COUNTRY" ]; then #Middle East- Bahrain
            set_wifi_val $PHY_IF CountryCode GB
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 2
        elif [ "EGY" = "$COUNTRY" ]; then #Middle East- Egypt
            set_wifi_val $PHY_IF CountryCode GB
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 2
        elif [ "KWT" = "$COUNTRY" ]; then #Middle East- Kuwait
            set_wifi_val $PHY_IF CountryCode GB
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 2
        elif [ "OMN" = "$COUNTRY" ]; then #Middle East- Oman
            set_wifi_val $PHY_IF CountryCode GB
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 2
        elif [ "QAT" = "$COUNTRY" ]; then #Middle East- Qatar
            set_wifi_val $PHY_IF CountryCode GB
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 2
        elif [ "TUR" = "$COUNTRY" ]; then #Middle East- Turkey
            set_wifi_val $PHY_IF CountryCode GB
            set_wifi_val $PHY_IF CountryRegion 1
            set_wifi_val $PHY_IF CountryRegionABand 1
        elif [ "USA" = "$COUNTRY" ]; then #US
            set_wifi_val $PHY_IF CountryCode US
            set_wifi_val $PHY_IF CountryRegion 0
            set_wifi_val $PHY_IF CountryRegionABand 10
        elif [ "TWN" = "$COUNTRY" ]; then #Taiwan
            set_wifi_val $PHY_IF CountryCode TH
            set_wifi_val $PHY_IF CountryRegion 0
            set_wifi_val $PHY_IF CountryRegionABand 10
        fi
    fi
