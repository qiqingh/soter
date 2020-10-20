   if [ "$SYSCFG_sip_alg_enabled" = "1" ]; then
      ulog ${SERVICE_NAME} status "starting ${SERVICE_NAME} service" 
      MODULE_PATH=/lib/modules/`uname -r`/
      if [ -f $MODULE_PATH/nf_conntrack_sip.ko ]; then           
         insmod $MODULE_PATH/nf_conntrack_sip.ko > /dev/null 2>&1
      fi                                                         
      if [ $? != 0 ]; then                                       
         ERROR1="can't insert nf_conntrack_sip.ko"
      else                                        
         ERROR1=""                                
      fi          
      if [ -f $MODULE_PATH/nf_nat_sip.ko ]; then           
         insmod $MODULE_PATH/nf_nat_sip.ko > /dev/null 2>&1
      fi                                                   
      if [ $? != 0 ]; then                                 
         ERROR2="can't insert nf_nat_sip.ko"
      else                                  
         ERROR2=""                          
      fi          
      if [ -n "$ERROR1" -o -n "$ERROR2" ];then
         sysevent set ${SERVICE_NAME}-errinfo "$ERROR1 $ERROR2"
         sysevent set ${SERVICE_NAME}-status "error"           
      else                                                     
         sysevent set ${SERVICE_NAME}-errinfo                  
         sysevent set ${SERVICE_NAME}-status "started"         
      fi                                                       
   fi
