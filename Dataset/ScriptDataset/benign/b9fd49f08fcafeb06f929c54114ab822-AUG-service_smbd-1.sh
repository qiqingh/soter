  gns=`syscfg show | grep group | grep _name=$1 | cut -d'_' -f1,2`
  gperms=`syscfg get ${gns}_perms`
  echo "$gperms"
