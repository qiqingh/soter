  echo `syscfg show | grep user_ | grep _username | grep "=$1$" | sort -n | head -n 1 | cut -d'_' -f2`
