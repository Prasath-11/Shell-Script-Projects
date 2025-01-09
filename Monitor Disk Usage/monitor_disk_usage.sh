#!/bin/bash

# Define the threshold for disk usage (80%)
THRESHOLD=80

# Define the log file location
LOG_FILE="/var/log/disk_usage_alert.log"

# Define the recipient email address
EMAIL_RECIPIENT="prasathgovindaraj11@gmail.com"

# Get the disk usage percentage of the root filesystem
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//')

# Get the current date and time for logging
DATE_TIME=$(date "+%Y-%m-%d %H:%M:%S")

# Check if disk usage exceeds the threshold
if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
    # Log the disk usage details to the log file
    echo "$DATE_TIME - WARNING: Disk usage is at ${DISK_USAGE}% on /" >> $LOG_FILE

    # Send an email alert
    SUBJECT="Disk Usage Alert: ${DISK_USAGE}% on /"
    BODY="Warning: The disk usage of the root filesystem has exceeded ${THRESHOLD}%. Current usage is ${DISK_USAGE}%. Please take necessary action."
    echo -e "Subject:${SUBJECT}\n\n${BODY}" | sendmail -v $EMAIL_RECIPIENT
else
    echo "$DATE_TIME : Disk usage is at ${DISK_USAGE}% on /" >> $LOG_FILE
fi

