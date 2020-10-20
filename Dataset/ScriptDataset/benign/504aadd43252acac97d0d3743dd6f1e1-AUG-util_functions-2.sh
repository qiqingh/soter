  if [ "$1" == "" ] ; then
    echo ""
    return
  fi
  local form_var="$1"
  local var_value=`echo "$QUERY_STRING" | sed -n "s/^.*$form_var=\([^&]*\).*$/\1/p" | sed "s/%20/ /g" | sed "s/+/ /g" | sed "s/%2F/\//g" | sed "s/,/ /g"`
  echo -n "$var_value"
