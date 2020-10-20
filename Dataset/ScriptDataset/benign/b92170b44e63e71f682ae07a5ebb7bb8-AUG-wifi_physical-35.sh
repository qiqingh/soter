	PHY_IF=$1
	SYSCFG_INDEX=`syscfg_get "$PHY_IF"_syscfg_index`
    PMF=`syscfg_get $SYSCFG_INDEX"_pmf"`
    if [ "enabled" = "$PMF" ]; then
		set_wifi_val $PHY_IF PMFMFPC 1
        echo "${SERVICE_NAME}, PMF enabled"
    else
		set_wifi_val $PHY_IF PMFMFPC 0
        echo "${SERVICE_NAME}, PMF disabled"
    fi
