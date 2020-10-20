    local post="${TMP_PREFIX}/readycloud_r.post"
    echo "${1}" > "${post}"
    comm_post_file "${post}" "${2}" || {
# 	rm -f "${post}"
	return $ERROR
    }
#     rm -f "${post}"
    return $OK
