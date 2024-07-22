#!/bin/bash

# Define the installation script URL and local file
INSTALL_SCRIPT_URL="https://dot.net/v1/dotnet-install.sh"
INSTALL_SCRIPT="dotnet-install.sh"
DOTNET_DIR="$HOME/.dotnet"

# Function to prompt for .NET version
prompt_version() {
    echo "Choose .NET version to install:"
    echo "1) 6"
    echo "2) 7"
    echo "3) 8"
    echo "4) Latest (LTS)"
    read -p "Enter your choice (1, 2, 3, 4): " CHOICE

    case $CHOICE in
        1)
            CHANNEL="6.0"
            ;;
        2)
            CHANNEL="7.0"
            ;;
        3)
            CHANNEL="8.0"
            ;;
        4)
            CHANNEL="LTS"
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
}

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --channel) CHANNEL="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# If no channel provided, prompt user
if [ -z "$CHANNEL" ]; then
    prompt_version
else
    echo "Selected .NET version: $CHANNEL"
fi

# Check for existing .NET installations
INSTALLED_VERSIONS=$(ls "$DOTNET_DIR" | grep -E "^sdk/([0-9]+\\.[0-9]+)")

# Handle existing installations
if [ -n "$INSTALLED_VERSIONS" ]; then
    echo "Existing .NET versions found:"
    echo "$INSTALLED_VERSIONS"
    echo "You are about to install version $CHANNEL."
    read -p "Do you want to proceed? (y/N): " PROCEED
    if [[ "$PROCEED" =~ ^[Yy]$ ]]; then
        echo "Proceeding with installation..."
    else
        echo "Installation aborted."
        exit 0
    fi
fi

# Download the .NET install script
echo "Downloading .NET install script..."
wget "$INSTALL_SCRIPT_URL" -O "$INSTALL_SCRIPT"
if [ $? -ne 0 ]; then
    echo "Failed to download $INSTALL_SCRIPT. Exiting."
    exit 1
fi

# Make the downloaded script executable
chmod +x "$INSTALL_SCRIPT"
if [ $? -ne 0 ]; then
    echo "Failed to make $INSTALL_SCRIPT executable. Exiting."
    exit 1
fi

# Install .NET
echo "Setting up .NET version $CHANNEL..."
./"$INSTALL_SCRIPT" --channel "$CHANNEL"
if [ $? -ne 0 ]; then
    echo "Failed to install .NET. Exiting."
    exit 1
fi

# Clean up install script
rm -f "$INSTALL_SCRIPT"

# Add .NET to PATH in the appropriate shell profile
PROFILE=""
if [ -f "$HOME/.bashrc" ]; then
    PROFILE="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    PROFILE="$HOME/.zshrc"  
else
    echo "No suitable shell profile found. Please add the PATH manually."
    exit 1
fi

# Add .NET paths to the profile
if ! grep -q "export DOTNET_ROOT=$DOTNET_DIR" "$PROFILE"; then
    echo "export DOTNET_ROOT=$DOTNET_DIR" >> "$PROFILE"
fi

if ! grep -q "export PATH=\$PATH:$DOTNET_DIR:$DOTNET_DIR/tools" "$PROFILE"; then
    echo "export PATH=\$PATH:$DOTNET_DIR:$DOTNET_DIR/tools" >> "$PROFILE"
fi

echo "PATH updated in $PROFILE. Please restart your terminal or run 'source $PROFILE' to apply changes."

echo "Setup completed successfully."
