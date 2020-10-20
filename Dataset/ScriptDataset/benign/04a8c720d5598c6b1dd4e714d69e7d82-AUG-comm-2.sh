    COMM_RESULT=""
    [ -z "${1}" ] && return $ERROR
    if [ -z "${2}" ];
    then
	FULL_EXEC="\`cat "${1}" | ${COMM_EXEC} -X POST --data-binary @- 2>/dev/null\`"
# 	FULL_EXEC="\`cat "${1}" | ${COMM_EXEC} -X POST --data-binary @- \`"
    else
# 	FULL_EXEC="\`cat "${1}" | ${COMM_EXEC} -X POST --data-binary @- > "${2}"\`"
	FULL_EXEC="\`cat "${1}" | ${COMM_EXEC} -X POST --data-binary @- 2>/dev/null -o '${2}'\`"
    fi
#     echo "${FULL_EXEC}"
    eval COMM_RESULT="${FULL_EXEC}" || return $ERROR

    return $OK
