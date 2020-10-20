   ulog "${SERVICE_NAME}, service_stop()"
   killall crond > /dev/null 2>&1
   sysevent set ${SERVICE_NAME}-status "stopped"
