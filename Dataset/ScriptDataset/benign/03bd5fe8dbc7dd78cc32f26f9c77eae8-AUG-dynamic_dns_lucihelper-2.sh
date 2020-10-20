			write_log 7 "-----> timeout 3 -- get_local_ip IP"
			timeout 3 -- get_local_ip IP
		} || {
			write_log 7 "-----> get_local_ip IP"
			get_local_ip IP
