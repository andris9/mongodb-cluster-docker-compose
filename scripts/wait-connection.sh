#!/bin/sh

printf "Waiting for a mongo connection to $1..."

max_attempts=100

# Set a counter for the number of attempts
attempt_num=1

# Set a flag to indicate whether the command was successful
success=false

while [ $success = false ] && [ $attempt_num -le $max_attempts ]; do
    mongo --quiet --eval "printjson('connected')" >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        # The command was successful
        success=true
        echo "connected"
    else
        attempt_num=$(( attempt_num + 1 ))
        printf .
        sleep 1
    fi
done

