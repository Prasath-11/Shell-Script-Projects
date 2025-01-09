#!/bin/bash

# Define the log file location
LOG_FILE="/var/log/cpu_mem_usage.log"

# Define the threshold values
CPU_THRESHOLD=90
MEMORY_THRESHOLD=75

# Get the current date and time for logging
DATE_TIME=$(date "+%Y-%m-%d %H:%M:%S")

# Get CPU usage (using top command to get the idle percentage and subtract it from 100)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Get Memory usage (using free command to get percentage of used memory)
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Log if CPU usage exceeds the threshold
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    echo "$DATE_TIME - WARNING: CPU usage is at ${CPU_USAGE}%." >> $LOG_FILE
else
    echo "$DATE_TIME : CPU usage is at ${CPU_USAGE}%." >> $LOG_FILE
fi

# Log if Memory usage exceeds the threshold
if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
    echo "$DATE_TIME - WARNING: Memory usage is at ${MEMORY_USAGE}%." >> $LOG_FILE
else
    echo "$DATE_TIME : Memory usage is at ${MEMORY_USAGE}%." >> $LOG_FILE
fi

echo "Monitoring complete."
