    TMP_SINGLE_SKU_BF=/tmp/7615_SingleSKU_BF.dat
    TMP_SINGLE_SKU=/tmp/7615_SingleSKU.dat
    ETC_SINGLE_SKU_BF=
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
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_FCC
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_FCC
    elif [ "CA" = "$REGION" ]; then
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_IC
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_IC
    elif [ "EU" = "$REGION" ]; then
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_CE
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_CE
    elif [ "AU" = "$REGION" ]; then
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_AU
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_AU
    elif [ "AH" = "$REGION" ]; then
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_CM
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_CM
    elif [ "HK" = "$REGION" ]; then
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_HK
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_HK
    elif [ "ME" = "$REGION" -o "BHR" = "$REGION" -o "EGY" = "$REGION" -o "KWT" = "$REGION" -o "OMN" = "$REGION" -o "QAT" = "$REGION" -o "SAU" = "$REGION" -o "ARE" = "$REGION" -o "TUR" = "$REGION" ]; then
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_CM
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_CM
    elif [ "IN" = "$REGION" ]; then
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_IN_new
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_IN_new
    elif [ "ID" = "$REGION" ]; then
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_ID_new
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_ID_new
    elif [ "PH" = "$REGION" ]; then
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_PH_new
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_PH_new
    elif [ "SG" = "$REGION" ]; then
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_SG_new
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_SG_new
    elif [ "CN" = "$REGION" ]; then
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_CN
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_CN
    elif [ "TW" = "$REGION" ]; then
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_TW
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_TW
    else
        echo "Unknown region \"$REGION\", use FCC power table by default"
        ETC_SINGLE_SKU_BF=/etc/7615_SingleSKU_BF.dat_FCC
        ETC_SINGLE_SKU=/etc/7615_SingleSKU.dat_FCC
    fi
    if [ "1" = "$MULTIREGION_SUPPORT" -a "1" = "$MULTIREGION_ENABLE" ]; then
	    echo "SingleSKU: $ETC_SINGLE_SKU, SingleSKUBF: $ETC_SINGLE_SKU_BF"
    fi
    rm -f $TMP_SINGLE_SKU_BF
    rm -f $TMP_SINGLE_SKU
    ln -s $ETC_SINGLE_SKU_BF  $TMP_SINGLE_SKU_BF
    ln -s $ETC_SINGLE_SKU  $TMP_SINGLE_SKU
