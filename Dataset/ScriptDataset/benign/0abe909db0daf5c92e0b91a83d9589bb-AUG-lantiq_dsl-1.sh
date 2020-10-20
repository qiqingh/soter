	killall -q -0 ${XDSL_CTRL} && (
		lock /var/lock/dsl_pipe
		echo "$@" > /tmp/pipe/dsl_cpe0_cmd
		cat /tmp/pipe/dsl_cpe0_ack
		lock -u /var/lock/dsl_pipe
	)
