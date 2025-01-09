#!/bin/bash

# Define the directory to search. Default is the current directory.
DIRECTORY="${1:-.}"

# Check if the directory exists
if [ ! -d "$DIRECTORY" ]; then
  echo "Error: $DIRECTORY is not a valid directory."
  exit 1
fi

# Find and delete files older than 30 days
find "$DIRECTORY" -type f -mtime +30 -exec echo {} \;
find "$DIRECTORY" -type f -mtime +30 -exec rm -f {} \;

# Provide feedback
echo "All files older than 30 days in $DIRECTORY have been deleted."
