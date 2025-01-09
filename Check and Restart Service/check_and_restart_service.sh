#!/bin/bash

# Define the service name (change to your desired service, e.g., httpd or nginx)
SERVICE_NAME="apache2"  # Change this to "nginx" if you are monitoring nginx

# Define the log file
LOG_FILE="/var/log/service_restart.log"

# Get the current date and time for logging
DATE_TIME=$(date "+%Y-%m-%d %H:%M:%S")

# Check if the service is running
if systemctl is-active --quiet "$SERVICE_NAME"; then
    echo "$DATE_TIME - INFO: $SERVICE_NAME is running." >> $LOG_FILE
else
    # If the service is not running, restart it
    echo "$DATE_TIME - WARNING: $SERVICE_NAME is not running. Restarting..." >> $LOG_FILE
    systemctl restart "$SERVICE_NAME"
    
    # Check if the restart was successful
    if systemctl is-active --quiet "$SERVICE_NAME"; then
        echo "$DATE_TIME - SUCCESS: $SERVICE_NAME has been restarted successfully." >> $LOG_FILE
    else
        echo "$DATE_TIME - ERROR: Failed to restart $SERVICE_NAME." >> $LOG_FILE
    fi
fi
