        time_stamp_dni=$(cat /proc/uptime)
        local content_type date

        content_type="$1"
        [ "x$content_type" = "x" ] && content_type="text/html"
        date=`date -u '+%a, %d %b %Y %H:%M:%S %Z'`

cat <<EOF
Content-type: $content_type

EOF
