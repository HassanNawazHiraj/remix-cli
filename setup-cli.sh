#!/bin/bash

# Default file name
filename="remix"

# Prompt user for file name
read -p "Enter cli keyword to use (default: $filename): " input_filename

# Use default file name if user input is empty
if [[ -z $input_filename ]]; then
  input_filename=$filename
fi

# Replace {{SCRIPT_PATH}} with the actual script path
sed "s/{{SCRIPT_PATH}}/$(pwd)/g" ./templates/remix > "$input_filename"

# Make the file executable
chmod +x "$input_filename"

# Copy the file to /usr/local/bin
mv "$input_filename" /usr/local/bin

echo "Cli is setup to use $input_filename now! You can run the cli using the command '$input_filename <command>'."
