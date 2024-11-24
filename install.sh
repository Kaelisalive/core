#!/bin/bash

echo "Starting installation process..."

# Detect OS and choose download tool
if command -v wget &> /dev/null; then
  DOWNLOAD_CMD="wget"
elif command -v curl &> /dev/null; then
  DOWNLOAD_CMD="curl -O"
else
  echo "Error: Neither wget nor curl is installed. Exiting."
  exit 1
fi

# Fetch the latest state file
$DOWNLOAD_CMD "https://raw.githubusercontent.com/Kaelisalive/core/refs/heads/main/kael.js" -O state.json

# Verify the state file exists
if [ ! -f state.json ]; then
  echo "Error: Failed to download state.json. Exiting."
  exit 1
fi

# Clone or update the repository
if [ -d "core" ]; then
  echo "Repository already exists. Pulling latest changes..."
  cd core
  git pull
else
  echo "Cloning the repository..."
  git clone https://github.com/Kaelisalive/core.git
  cd core
fi

# Install dependencies
if [ -f package.json ]; then
  npm install
else
  echo "Warning: No package.json found. Skipping dependency installation."
fi

echo "Installation complete!"
