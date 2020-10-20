	if_name=$1
	iwpriv $if_name filter 0
	iwpriv $if_name filtermac "deleteall"
