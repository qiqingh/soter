   wait_till_end_state ${SERVICE_NAME}
   if [ "$(sysevent get ${SERVICE_NAME}-status)" != "stopped" ]; then
      sysevent set ${SERVICE_NAME}-status "stopping"
      sysevent set ${SERVICE_NAME}-errinfo
      sysevent set ${SERVICE_NAME}-status "stopped"
      echo "${SERVICE_NAME} service stopped" >> /dev/console
      ulog ${SERVICE_NAME} status "${SERVICE_NAME} service stopped" 
   fi
