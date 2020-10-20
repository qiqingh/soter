    CHECK=${2:-NULL}
    if [ $CHECK = "NULL" ]; then
     mf_feedback "ERROR: Necessary service setting not found: $1 - aborting." 
     exit 1
    fi
