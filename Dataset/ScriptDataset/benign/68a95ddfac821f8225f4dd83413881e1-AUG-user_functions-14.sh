  echo `syscfg show | grep "$1" | cut -d'_' -f1,2`
