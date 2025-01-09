#!/bin/bash

# Define the directory to backup (change this to the directory you want to back up)
SOURCE_DIR="/home/ubuntu/parent_dir/src_dir"

# Define the backup destination directory
BACKUP_DIR="/home/ubuntu/parent_dir/backup_dir"

# Get the current date in the format YYYY-MM-DD
CURRENT_DATE=$(date "+%Y-%m-%d")

# Define the backup filename with the current date
BACKUP_FILE="${BACKUP_DIR}/backup_${CURRENT_DATE}.tar.gz"

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Source directory $SOURCE_DIR does not exist."
  exit 1
fi

# Check if the backup destination directory exists, if not, create it
if [ ! -d "$BACKUP_DIR" ]; then
  echo "Backup directory $BACKUP_DIR does not exist. Creating it..."
  mkdir -p "$BACKUP_DIR"
fi

# Perform the backup and compression
tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" .

# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "Backup completed successfully: $BACKUP_FILE"
else
  echo "Error: Backup failed."
  exit 1
fi
