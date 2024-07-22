#!/bin/bash

# Function to prompt for and confirm the PostgreSQL password
prompt_password() {
    while true; do
        read -sp "Enter PostgreSQL password: " PASSWORD1
        echo
        read -sp "Confirm PostgreSQL password: " PASSWORD2
        echo
        
        if [ "$PASSWORD1" = "$PASSWORD2" ]; then
            PASSWORD="$PASSWORD1"
            break
        else
            echo "Passwords do not match. Please try again."
        fi
    done
}

# Prompt for PostgreSQL password
prompt_password

# Update package list and install PostgreSQL
echo "Updating package database and installing PostgreSQL..."
sudo pacman -Syu --noconfirm postgresql

# Initialize the PostgreSQL database
echo "Initializing PostgreSQL database..."
sudo su -c "postgres-initdb -D /var/lib/postgres/data"

# Start and enable PostgreSQL service
echo "Starting and enabling PostgreSQL service..."
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Check the status of PostgreSQL service
echo "Checking PostgreSQL service status..."
sudo systemctl status postgresql

# Set up PostgreSQL password
echo "Setting PostgreSQL password..."
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '$PASSWORD';"

echo "PostgreSQL setup completed successfully."
