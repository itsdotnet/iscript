#!/bin/bash

# Define the repository directory and target directory
REPO_DIR="$(dirname "$(realpath "$0")")"
TARGET_DIR="$HOME/.isc"

# Copy the repository to ~/.isc
if [ -d "$TARGET_DIR" ]; then
    echo "$TARGET_DIR already exists. Removing old directory."
    rm -rf "$TARGET_DIR"
fi
echo "Copying repository to $TARGET_DIR."
cp -r "$REPO_DIR" "$TARGET_DIR"

# Define new repository directory path
REPO_DIR="$TARGET_DIR/$(basename "$REPO_DIR")"

# Make the scripts executable
chmod +x "$REPO_DIR/isc"
chmod +x "$REPO_DIR/update.sh"

# Determine the shell profile
if [ -f "$HOME/.bashrc" ]; then
    PROFILE="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    PROFILE="$HOME/.zshrc"
else
    echo "No suitable shell profile found. Please add the PATH manually."
    exit 1
fi

# Add the new path to the PATH in the profile
if ! grep -q "export PATH=\"$REPO_DIR:\$PATH\"" "$PROFILE"; then
    echo "export PATH=\"$REPO_DIR:\$PATH\"" >> "$PROFILE"
    echo "PATH updated in $PROFILE. Please restart your terminal or run 'source $PROFILE' to apply changes."
else
    echo "PATH already updated in $PROFILE."
fi

echo "Setup completed successfully."
