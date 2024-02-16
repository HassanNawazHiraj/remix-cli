#!/bin/bash

echo "Updating CLI..."

# Change to the directory of the script
cd "$(dirname "$0")"

# Get the latest commit hash
before_update=$(git rev-parse HEAD)

# Fetch the remote repository
git fetch > /dev/null 2>&1

# Get the latest commit hash on the remote repository
after_update=$(git rev-parse origin/master)

# If the commit hashes are different, reset the local repository and make the script executable
if [ "$before_update" != "$after_update" ]; then
    # Reset the local repository to match the remote repository
    git reset --hard origin/master > /dev/null 2>&1

    # Make the script executable
    chmod +x *.sh

    echo -e "\nCLI updated."
else
    echo -e "\nNo updates available."
fi