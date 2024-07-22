#!/bin/bash

# Function to prompt for .NET version
prompt_version() {
    echo "Choose .NET version to install:"
    echo "1) 6"
    echo "2) 7"
    echo "3) 8"
    read -p "Enter your choice (1, 2, 3): " CHOICE

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

echo "Setting up .NET version $CHANNEL..."
# Commands to set up the specified .NET version
# Example commands (adjust as needed):
# wget https://download.visualstudio.microsoft.com/download/pr/<url_to_dotnet_version>/dotnet-sdk-$CHANNEL-linux-x64.tar.gz
# tar -xzvf dotnet-sdk-$CHANNEL-linux-x64.tar.gz
# sudo mv dotnet /usr/local/bin/

# Replace the above commands with actual setup steps for the specified version.
