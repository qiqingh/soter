    wget -O - http://www.milkfish.org/audit/results/$( echo $(nvram get milkfish_routerid) | cut -c1-16 )-results.txt
