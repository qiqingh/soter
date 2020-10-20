    echo $(ps | grep openser | wc -l | awk '{print $1}')
