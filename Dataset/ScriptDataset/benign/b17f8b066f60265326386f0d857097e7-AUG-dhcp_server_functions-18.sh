   cat /tmp/dnsmasq.leases | awk '{print $3 " " $2 " " $4}'
