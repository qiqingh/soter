   if (set -o noclobber; echo "$$" > "$USB_LOCK_FILE") 2> /dev/null; then        # Try to lock a file
      trap 'rm -f "$USB_LOCK_FILE"; exit $?' INT TERM EXIT;                      # Remove a lock file in abnormal termination.
      return 0;                                                                  # Locked
   fi
   return 1                                                                      # Failure
