	IF_NAME=$1
	iwpriv $IF_NAME filter 0
	iwpriv $IF_NAME filtermac "deleteall"
