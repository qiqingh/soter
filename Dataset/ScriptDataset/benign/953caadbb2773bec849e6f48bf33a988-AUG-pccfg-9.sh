	POLICY=$1
	
	CAT="00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"

	COUNT=`syscfg get pcp_$POLICY::blocked_category_count`
	if [ "$COUNT" == "" ]; then
		COUNT=0;
	fi
	for i in `seq 1 $COUNT`; do
		eval bc=`syscfg get pcp_$POLICY::blocked_category_ex_$i`
		eval RIGHT=`expr $bc + 1`
		eval TEMP=${CAT:0:$bc}1${CAT:$RIGHT}
		eval CAT=$TEMP
	done
	echo "  category: $CAT"
