#!/bin/bash

echo "Updating CLI..."

# Fetch the remote repository
git fetch > /dev/null 2>&1

# Reset the local repository to match the remote repository
git reset --hard origin/master > /dev/null 2>&1

# Make the script executable
chmod +x *.sh

echo -e "\nCLI updated."