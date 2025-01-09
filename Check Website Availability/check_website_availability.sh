#!/bin/bash

# List of websites to check (modify this list as needed)
WEBSITES=("http://example.com" "http://anotherexample.com" "https://yetanotherexample.com")

# Log file for storing unreachable websites
LOG_FILE="/var/log/website_availability.log"

# Email address for sending alerts (change to your email)
ALERT_EMAIL="your-email@example.com"

# Get the current date and time for logging
DATE_TIME=$(date "+%Y-%m-%d %H:%M:%S")

# Loop through each website in the list
for WEBSITE in "${WEBSITES[@]}"; do
    # Check the availability of the website using curl
    # -s: silent mode, -I: only fetch the HTTP header, -w: print the HTTP response code
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$WEBSITE")

    # Check if the HTTP status is not 200 (OK)
    if [[ "$HTTP_STATUS" -ne 200 ]]; then
        # Log the URL and the status code to the log file
        echo "$DATE_TIME - ERROR: $WEBSITE is unreachable. Status code: $HTTP_STATUS" >> $LOG_FILE
        
        # Send an email alert
        echo "Website $WEBSITE is unreachable. Status code: $HTTP_STATUS" | mail -s "Website Unreachable Alert" "$ALERT_EMAIL"
    else
        echo "$DATE_TIME - INFO: $WEBSITE is reachable." >> $LOG_FILE
    fi
done
