    log_info "wifi" "wlanMpt_update"
    local support enable region selectedCountry dfs_enable

    json_load "$(objReq wlanMpt json)"
    json_select "WlanMptP"
    json_get_vars support enable region selectedCountry dfs_enable

    log_info "wifi" "support:$support, enable:$enable, region:$region, selectedCountry:$selectedCountry, dfs_enable:$dfs_enable"

    local CountryRegion CountryRegionABand CountryCode


    if [ "$region" = "US" ]; then

        CountryRegion=0 && CountryRegionABand=10 && CountryCode=US && wlanMpt_singleSKU USA
        objReq wlanMpt setparam selectedCountry USA

    elif [ "$region" = "CA" ]; then
        CountryRegion=0 && CountryRegionABand=10 && CountryCode=CA && wlanMpt_singleSKU CAN
        objReq wlanMpt setparam selectedCountry CAN

    elif [ "$region" = "CN" -o "$region" = "AH" -o "$region" = "KR" ] && [ "$dfs_enable" = "1" ]; then
        # dfs_enable
        [ "$selectedCountry" = "USA" ] &&  CountryRegion=0 && CountryRegionABand=10 && CountryCode=US && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "CAN" ] &&  CountryRegion=0 && CountryRegionABand=10 && CountryCode=CA && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "CHN" ] &&  CountryRegion=1 && CountryRegionABand=10 && CountryCode=CN && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "HKG" ] &&  CountryRegion=0 && CountryRegionABand=7  && CountryCode=HK && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "MAC" ] &&  CountryRegion=0 && CountryRegionABand=7  && CountryCode=MO && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "IND" ] &&  CountryRegion=0 && CountryRegionABand=7  && CountryCode=IN && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "PHI" ] &&  CountryRegion=0 && CountryRegionABand=7  && CountryCode=US && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "SGP" ] &&  CountryRegion=1 && CountryRegionABand=7  && CountryCode=SG && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "THA" ] &&  CountryRegion=1 && CountryRegionABand=7  && CountryCode=TH && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "TWN" ] &&  CountryRegion=0 && CountryRegionABand=7  && CountryCode=TW && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "KOR" ] &&  CountryRegion=1 && CountryRegionABand=10 && CountryCode=TW && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "MYS" ] &&  CountryRegion=1 && CountryRegionABand=7  && CountryCode=HK && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "VNM" ] &&  CountryRegion=0 && CountryRegionABand=10 && CountryCode=VN && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "XAH" ] &&  CountryRegion=1 && CountryRegionABand=7  && CountryCode=AH && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "EEE" ] &&  CountryRegion=1 && CountryRegionABand=6  && CountryCode=EU && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "AUS" ] &&  CountryRegion=1 && CountryRegionABand=6  && CountryCode=EU && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "NZL" ] &&  CountryRegion=1 && CountryRegionABand=6  && CountryCode=EU && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "XME" ] &&  CountryRegion=1 && CountryRegionABand=6  && CountryCode=EU && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "SAU" ] &&  CountryRegion=1 && CountryRegionABand=6  && CountryCode=EU && wlanMpt_singleSKU $selectedCountry

    elif [ "$region" = "CN" -o "$region" = "AH" -o "$region" = "KR" ] && [ "$dfs_enable" = "0" ]; then
        #dfs_enable = 0
        [ "$selectedCountry" = "USA" ] &&  CountryRegion=0 && CountryRegionABand=10 && CountryCode=US && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "CAN" ] &&  CountryRegion=0 && CountryRegionABand=10 && CountryCode=CA && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "CHN" ] &&  CountryRegion=1 && CountryRegionABand=10 && CountryCode=CN && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "HKG" ] &&  CountryRegion=0 && CountryRegionABand=10 && CountryCode=HK && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "MAC" ] &&  CountryRegion=1 && CountryRegionABand=10 && CountryCode=MO && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "IND" ] &&  CountryRegion=0 && CountryRegionABand=10 && CountryCode=IN && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "PHI" ] &&  CountryRegion=1 && CountryRegionABand=10 && CountryCode=US && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "SGP" ] &&  CountryRegion=1 && CountryRegionABand=10 && CountryCode=SG && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "THA" ] &&  CountryRegion=1 && CountryRegionABand=10 && CountryCode=TH && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "TWN" ] &&  CountryRegion=0 && CountryRegionABand=10 && CountryCode=TW && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "KOR" ] &&  CountryRegion=1 && CountryRegionABand=10 && CountryCode=KR && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "MYS" ] &&  CountryRegion=1 && CountryRegionABand=6  && CountryCode=HK && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "VNM" ] &&  CountryRegion=1 && CountryRegionABand=10 && CountryCode=VN && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "XAH" ] &&  CountryRegion=1 && CountryRegionABand=6  && CountryCode=AH && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "EEE" ] &&  CountryRegion=1 && CountryRegionABand=6  && CountryCode=EU && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "AUS" ] &&  CountryRegion=1 && CountryRegionABand=6  && CountryCode=EU && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "NZL" ] &&  CountryRegion=1 && CountryRegionABand=6  && CountryCode=EU && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "XME" ] &&  CountryRegion=1 && CountryRegionABand=6  && CountryCode=EU && wlanMpt_singleSKU $selectedCountry
        [ "$selectedCountry" = "SAU" ] &&  CountryRegion=1 && CountryRegionABand=6  && CountryCode=EU && wlanMpt_singleSKU $selectedCountry


    fi

    log_info "wifi" "CountryRegion:$CountryRegion, CountryRegionABand:$CountryRegionABand, CountryCode:$CountryCode"
    wificonf -f $PATH_24G set CountryRegion $CountryRegion
    wificonf -f $PATH_24G  set CountryCode $CountryCode

    wificonf -f $PATH_5G  set CountryRegionABand $CountryRegionABand
    wificonf -f $PATH_5G  set CountryCode $CountryCode

