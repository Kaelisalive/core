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
STATE_URL="https://raw.githubusercontent.com/Kaelisalive/core/refs/heads/main/system/state.json"
echo "Fetching state file from $STATE_URL..."
$DOWNLOAD_CMD "$STATE_URL" -O state.json

# Verify the state file exists
if [ ! -f state.json ]; then
  echo "Error: Failed to download state.json. Exiting."
  exit 1
fi

echo "State file downloaded successfully."

# Parse the state file to extract repository URL (optional, if dynamic repo is needed)
if command -v jq &> /dev/null; then
  REPO_URL=$(jq -r '.config.repository' state.json)
  if [ -z "$REPO_URL" ]; then
    echo "Error: Repository URL not found in state.json. Using default."
    REPO_URL="https://github.com/Kaelisalive/core.git"
  fi
else
  echo "Warning: jq is not installed. Using default repository URL."
  REPO_URL="https://github.com/Kaelisalive/core.git"
fi

# Clone or update the repository
if [ -d "core" ]; then
  echo "Repository already exists. Pulling latest changes..."
  cd core || exit 1
  git pull
else
  echo "Cloning the repository from $REPO_URL..."
  git clone "$REPO_URL" core
  cd core || exit 1
fi

# Install dependencies
if [ -f package.json ]; then
  echo "Installing dependencies from package.json..."
  npm install
else
  echo "Warning: No package.json found. Skipping dependency installation."
fi

echo "Installation process complete!"
