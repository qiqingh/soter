  ulog ddns status "$PID clear_ddns_status"
  sysevent set ddns_return_status
  sysevent set ${SERVICE_NAME}-errinfo
  sysevent set ddns_internet_ipv4  
