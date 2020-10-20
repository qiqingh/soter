    cp_log_header "Checking $4 size $1"
    if [ $1 -ge $2 ]; then
	cp_log_header ">= $2"
	cp_log_result 0
    elif [ $1 -lt $3 ]; then
	cp_log_header "< $3"
	cp_log_result 1
    else
	cp_log_header "falls between $2 and $3"
	cp_log_result -1
    fi
