#!/bin/bash

echo "Updating CLI..."

# Fetch the remote repository
git fetch origin

# Reset the local repository to match the remote repository
git reset --hard origin/main

# Make the script executable
chmod +x *.sh