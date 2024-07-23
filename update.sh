#!/bin/bash

# Define the repository directory
REPO_DIR="$HOME/.isc/"
SCRIPT_NAME="isc"

# Check if the repository directory exists
if [ ! -d "$REPO_DIR" ]; then
    echo "Repository directory not found. Exiting."
    exit 1
fi

# Pull the latest changes from the repository
echo "Pulling the latest changes from the repository..."
cd "$REPO_DIR" || { echo "Failed to navigate to repository directory. Exiting."; exit 1; }
git pull origin main || { echo "Failed to pull from repository. Exiting."; exit 1; }

# Make the script executable    
chmod +x "$REPO_DIR/$SCRIPT_NAME"

# Ensure the old `isc` in the PATH is not being used
# The `isc` executable should already be in the PATH from the user's profile
# No need to copy to /usr/local/bin or similar locations

# Print success message
echo "Update completed successfully. Ensure your PATH includes $REPO_DIR."
