    cp_log_header "Checking command $1 $2 $3 $4 $5 $6 $7 $8 $9..."
    ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8} ${9}
    CMD_RESULT=$?
    cp_log_result ${CMD_RESULT}
    return ${CMD_RESULT}
