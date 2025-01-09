#!/bin/bash

# Get the current date in the format YYYY-MM-DD
CURRENT_DATE=$(date "+%Y-%m-%d")

# Define the directory (default is current directory)
DIRECTORY="${1:-.}"

# Convert relative path to absolute path for consistency
DIRECTORY=$(realpath "$DIRECTORY")

# Check if the directory exists
if [ ! -d "$DIRECTORY" ]; then
  echo "Error: $DIRECTORY is not a valid directory."
  exit 1
fi

# Check if there are any .txt files in the directory
if [ -z "$(ls "$DIRECTORY"/*.txt 2>/dev/null)" ]; then
  echo "No .txt files found in $DIRECTORY."
  exit 0
fi

# Loop through all .txt files in the specified directory
for FILE in "$DIRECTORY"/*.txt; do
  # Check if the file exists to avoid errors if no .txt files are present
  if [ -f "$FILE" ]; then
    # Get the file extension and filename without the extension
    BASENAME=$(basename "$FILE" .txt)
    
    # Construct the new filename with the current date
    NEW_FILENAME="${DIRECTORY}/${BASENAME}_${CURRENT_DATE}.txt"
    
    # Rename the file
    mv "$FILE" "$NEW_FILENAME"
    
    # Provide feedback
    echo "Renamed: $FILE -> $NEW_FILENAME"
  fi
done

echo "Renaming complete."
