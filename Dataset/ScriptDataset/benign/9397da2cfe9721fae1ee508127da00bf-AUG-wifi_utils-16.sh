	if_name=$1
	iwpriv $if_name maccmd 3
	iwpriv $if_name maccmd 0
