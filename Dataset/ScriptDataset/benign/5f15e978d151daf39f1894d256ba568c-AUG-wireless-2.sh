   local Selected_Country=$1
   local tmp_PATH_SKU_24G tmp_PATH_SKU_5G  tmp_PATH_BF_5G

    # SKU
    [ "$Selected_Country" = "CHN" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.CN  && tmp_PATH_SKU_5G=$PATH_SKU_5G.CN  && tmp_PATH_BF_5G=$PATH_BF_5G.CN
    [ "$Selected_Country" = "HKG" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.HK  && tmp_PATH_SKU_5G=$PATH_SKU_5G.HK  && tmp_PATH_BF_5G=$PATH_BF_5G.HK
    [ "$Selected_Country" = "MAC" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.MO  && tmp_PATH_SKU_5G=$PATH_SKU_5G.MO  && tmp_PATH_BF_5G=$PATH_BF_5G.MO
    [ "$Selected_Country" = "IND" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.IN  && tmp_PATH_SKU_5G=$PATH_SKU_5G.IN  && tmp_PATH_BF_5G=$PATH_BF_5G.IN
    [ "$Selected_Country" = "PHI" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.PH  && tmp_PATH_SKU_5G=$PATH_SKU_5G.PH  && tmp_PATH_BF_5G=$PATH_BF_5G.PH
    [ "$Selected_Country" = "SGP" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.SG  && tmp_PATH_SKU_5G=$PATH_SKU_5G.SG  && tmp_PATH_BF_5G=$PATH_BF_5G.SG
    [ "$Selected_Country" = "THA" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.TH  && tmp_PATH_SKU_5G=$PATH_SKU_5G.TH  && tmp_PATH_BF_5G=$PATH_BF_5G.TH
    [ "$Selected_Country" = "TWN" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.TW  && tmp_PATH_SKU_5G=$PATH_SKU_5G.TW  && tmp_PATH_BF_5G=$PATH_BF_5G.TW
    [ "$Selected_Country" = "KOR" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.KR  && tmp_PATH_SKU_5G=$PATH_SKU_5G.KR  && tmp_PATH_BF_5G=$PATH_BF_5G.KR
    [ "$Selected_Country" = "MYS" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.MY  && tmp_PATH_SKU_5G=$PATH_SKU_5G.MY  && tmp_PATH_BF_5G=$PATH_BF_5G.MY
    [ "$Selected_Country" = "VNM" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.VN  && tmp_PATH_SKU_5G=$PATH_SKU_5G.VN  && tmp_PATH_BF_5G=$PATH_BF_5G.VN
    [ "$Selected_Country" = "XAH" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.XAH && tmp_PATH_SKU_5G=$PATH_SKU_5G.XAH && tmp_PATH_BF_5G=$PATH_BF_5G.XAH

    [ "$Selected_Country" = "EEE" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.CE  && tmp_PATH_SKU_5G=$PATH_SKU_5G.CE  && tmp_PATH_BF_5G=$PATH_BF_5G.CE
    [ "$Selected_Country" = "AUS" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.AU  && tmp_PATH_SKU_5G=$PATH_SKU_5G.AU  && tmp_PATH_BF_5G=$PATH_BF_5G.AU
    [ "$Selected_Country" = "NZL" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.NZ  && tmp_PATH_SKU_5G=$PATH_SKU_5G.NZ  && tmp_PATH_BF_5G=$PATH_BF_5G.NZ
    [ "$Selected_Country" = "XME" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.XME && tmp_PATH_SKU_5G=$PATH_SKU_5G.XME && tmp_PATH_BF_5G=$PATH_BF_5G.XME
    [ "$Selected_Country" = "SAU" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.SA  && tmp_PATH_SKU_5G=$PATH_SKU_5G.SA  && tmp_PATH_BF_5G=$PATH_BF_5G.SA

    [ "$Selected_Country" = "CAN" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.CA  && tmp_PATH_SKU_5G=$PATH_SKU_5G.CA  && tmp_PATH_BF_5G=$PATH_BF_5G.CA

    [ "$Selected_Country" = "USA" ] && tmp_PATH_SKU_24G=$PATH_SKU_24G.FCC && tmp_PATH_SKU_5G=$PATH_SKU_5G.FCC && tmp_PATH_BF_5G=$PATH_BF_5G.FCC


    # SKU
    ln -sf $tmp_PATH_SKU_24G $PATH_SKU_24G
    ln -sf $tmp_PATH_SKU_5G  $PATH_SKU_5G
    # BF
    ln -sf $tmp_PATH_BF_5G   $PATH_BF_5G
    log_info "wifi" "sku_file_2g:$tmp_PATH_SKU_24G"
    log_info "wifi" "sku_file_5g:$tmp_PATH_SKU_5G"
    log_info "wifi" "sku_bf_file_5g:$tmp_PATH_BF_5G"
