   parse_wan_namespace_sysevent $1
   wan_info_by_namespace $NAMESPACE
   eval `utctx_cmd get dslite_aftr dslite_ipv4_address dslite_peer_ipv4_address`
