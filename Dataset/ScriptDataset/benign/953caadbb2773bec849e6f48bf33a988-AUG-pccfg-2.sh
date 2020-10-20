	NAME=$1
	POLICY=$2
	VALUE=$3

	syscfg_set pcp_$POLICY::$NAME $VALUE
