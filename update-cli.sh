#!/bin/bash

echo "Updating CLI..."

# Fetch the remote repository
git fetch

# Reset the local repository to match the remote repository
git reset --hard origin/master

# Make the script executable
chmod +x *.sh