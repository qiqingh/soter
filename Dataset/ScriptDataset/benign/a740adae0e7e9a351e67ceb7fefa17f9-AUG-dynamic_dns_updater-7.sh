	verify_proxy "$proxy" && {
		export HTTP_PROXY="http://$proxy"
		export HTTPS_PROXY="http://$proxy"
		export http_proxy="http://$proxy"
		export https_proxy="http://$proxy"
	}
