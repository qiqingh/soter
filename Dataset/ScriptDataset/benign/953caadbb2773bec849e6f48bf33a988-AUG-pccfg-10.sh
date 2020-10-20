	POLICY=$1

	echo "[Policy #$POLICY]"
	echo "  number: `syscfg get pcp_$POLICY::number`"
	echo "  status: `syscfg get pcp_$POLICY::status`"
	echo "  name: `syscfg get pcp_$POLICY::name`"
	echo "  safe_surfing: `syscfg get pcp_$POLICY::safe_surfing`"
	echo "  device:"
	COUNT=`syscfg get pcp_$POLICY::blocked_device_count`
	if [ "$COUNT" == "" ]; then
		COUNT=0;
	fi
	for i in `seq 1 $COUNT`; do
		echo "    `syscfg get pcp_$POLICY::blocked_device_$i` `syscfg get pcp_$POLICY::blocked_device_uuid_$i`"
	done
	get_category $POLICY
	echo "  schedule:"
	echo "    mon: `syscfg get pcp_$POLICY::monday_time_blocks`"
	echo "    tue: `syscfg get pcp_$POLICY::tuesday_time_blocks`"
	echo "    wed: `syscfg get pcp_$POLICY::wednesday_time_blocks`"
	echo "    thu: `syscfg get pcp_$POLICY::thursday_time_blocks`"
	echo "    fri: `syscfg get pcp_$POLICY::friday_time_blocks`"
	echo "    sat: `syscfg get pcp_$POLICY::saturday_time_blocks`"
	echo "    sun: `syscfg get pcp_$POLICY::sunday_time_blocks`"
	echo "  blocked urls:"
	COUNT=`syscfg get pcp_$POLICY::blocked_url_count`
	if [ "$COUNT" == "" ]; then
		COUNT=0;
	fi
	for i in `seq 1 $COUNT`; do
		echo "    `syscfg get pcp_$POLICY::blocked_url_$i`"
	done
	echo "  allowed urls:"
	COUNT=`syscfg get pcp_$POLICY::allowed_url_count`
	if [ "$COUNT" == "" ]; then
		COUNT=0;
	fi
	for i in `seq 1 $COUNT`; do
		echo "    `syscfg get pcp_$POLICY::allowed_url_$i`"
	done
	echo "  blocked ports:"
	COUNT=`syscfg get pcp_$POLICY::blocked_port_count`
	if [ "$COUNT" == "" ]; then
		COUNT=0;
	fi
	for i in `seq 1 $COUNT`; do
		echo "    `syscfg get pcp_$POLICY::blocked_port_name_$i`/`syscfg get pcp_$POLICY::blocked_port_proto_$i`,`syscfg get pcp_$POLICY::blocked_port_start_$i`-`syscfg get pcp_$POLICY::blocked_port_end_$i`"
	done
