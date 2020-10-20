 #!/bin/sh
 echo [$0] ... > /dev/console
 TROOT="/etc/templates"
 case "$1" in
 start)
    [ -f /etc/templates/ap_array_scan.sh ] && sh /etc/templates/ap_array_scan.sh > /dev/console
     xmldbc -A $TROOT/ap_array_scan.php -V generate_start=1 > /var/run/aparray_scan.sh
     sh /var/run/aparray_scan.sh > /dev/console
     ;;
 esac

