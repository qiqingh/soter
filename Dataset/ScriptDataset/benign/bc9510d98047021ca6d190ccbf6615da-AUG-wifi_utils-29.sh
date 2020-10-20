	WL_SYSCFG=$1
	ENCRYPTION_MODE=""
	SEC_MODE=`syscfg get "$WL_SYSCFG"_security_mode`
	if [ "wep" = "$SEC_MODE" ] || [ "wep-auto" = "$SEC_MODE" ] || [ "wep-open" = "$SEC_MODE" ] || [ "wep-shared" = "$SEC_MODE" ]; then
		TX_KEY=`syscfg get "$WL_SYSCFG"_tx_key`
		INDEX_KEY=`expr $TX_KEY - 1`
		CURRENT_KEY=`syscfg get "$WL_SYSCFG"_key_"$INDEX_KEY"`
		CURRENT_KL=`echo $CURRENT_KEY | wc -c`
		if [ 11 = `expr $CURRENT_KL` ] || [ 6 = `expr $CURRENT_KL` ]; then
			ENCRYPTION_MODE="64-bits"
		elif [ 27 = `expr $CURRENT_KL` ] || [ 14 = `expr $CURRENT_KL` ]; then
			ENCRYPTION_MODE="128-bits"
		fi
	fi
	echo "$ENCRYPTION_MODE"	
