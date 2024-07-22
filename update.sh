#!/bin/bash

# Determine the directory of the update.sh script
REPO_DIR="$(dirname "$(realpath "$0")")"

# Define variables      
SCRIPT_NAME=isc
DESTINATION=/usr/local/bin/$SCRIPT_NAME

# Navigate to the repository directory
cd "$REPO_DIR" || { echo "Repository directory not found. Exiting."; exit 1; }

# Pull the latest changes from the repository
echo "Pulling the latest changes from the repository..."
git pull origin main || { echo "Failed to pull from repository. Exiting."; exit 1; }

# Make the script executable
chmod +x $SCRIPT_NAME

# Copy the updated script to /usr/local/bin
echo "Copying the updated script to /usr/local/bin..."
sudo cp $SCRIPT_NAME $DESTINATION || { echo "Failed to copy script to $DESTINATION. Exiting."; exit 1; }

# Update script paths in isc
sed -i "s|./scripts/|$REPO_DIR/scripts/|" $DESTINATION

# Print success message
echo "Update completed successfully."
