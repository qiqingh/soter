    TMP_SINGLE_SKU=/tmp/SingleSKU.dat
    ETC_SINGLE_SKU=
    MULTIREGION_SUPPORT=`syscfg_get wifi::multiregion_support`
    MULTIREGION_ENABLE=`syscfg_get wifi::multiregion_enable`
    REGION=""
    if [ "1" = "$MULTIREGION_SUPPORT" -a "1" = "$MULTIREGION_ENABLE" ]; then
        echo "Multi-region is supported and enabled"
        REGION=`syscfg_get wifi::multiregion_region`
        echo "Region: $REGION"
    else
        echo "Multi-region is not supported or not enabled"
	    REGION=`syscfg_get device::cert_region`
        echo "Cert region: $REGION"
    fi
    if [ "US" = "$REGION" ]; then
        ETC_SINGLE_SKU=/etc/SingleSKU.dat_FCC
    elif [ "CA" = "$REGION" ]; then
        ETC_SINGLE_SKU=/etc/SingleSKU.dat_IC
    elif [ "EU" = "$REGION" ]; then
        ETC_SINGLE_SKU=/etc/SingleSKU.dat_CE
    elif [ "AU" = "$REGION" ]; then
        ETC_SINGLE_SKU=/etc/SingleSKU.dat_AU
    elif [ "AH" = "$REGION" ]; then
        ETC_SINGLE_SKU=/etc/SingleSKU.dat_AH
    elif [ "HK" = "$REGION" ]; then
        ETC_SINGLE_SKU=/etc/SingleSKU.dat_IC
    elif [ "ME" = "$REGION" -o "BHR" = "$REGION" -o "EGY" = "$REGION" -o "KWT" = "$REGION" -o "OMN" = "$REGION" -o "QAT" = "$REGION" -o "SAU" = "$REGION" -o "ARE" = "$REGION" -o "TUR" = "$REGION" ]; then
        ETC_SINGLE_SKU=/etc/SingleSKU.dat_ME
    elif [ "IN" = "$REGION" ]; then
        ETC_SINGLE_SKU=/etc/SingleSKU.dat_IN_new
    elif [ "ID" = "$REGION" ]; then
        ETC_SINGLE_SKU=/etc/SingleSKU.dat_ID_new
    elif [ "PH" = "$REGION" ]; then
        ETC_SINGLE_SKU=/etc/SingleSKU.dat_PH_new
    elif [ "SG" = "$REGION" ]; then
        ETC_SINGLE_SKU=/etc/SingleSKU.dat_SG_new
    else
        echo "Unknown region \"$REGION\", use FCC power table by default"
        ETC_SINGLE_SKU=/etc/SingleSKU.dat_FCC
    fi
	    echo "MT7603E SingleSKU: $ETC_SINGLE_SKU"
    rm -f $TMP_SINGLE_SKU
    ln -s $ETC_SINGLE_SKU  $TMP_SINGLE_SKU
