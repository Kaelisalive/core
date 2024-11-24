#!/bin/bash

echo "Starting multi-instance deployment..."

# Fetch the system state file
wget -q "https://raw.githubusercontent.com/Kaelisalive/core/refs/heads/main/state.json" -O state.json
if [ $? -ne 0 ]; then
  echo "Failed to fetch system state. Exiting."
  exit 1
fi

# Parse sibling instances and start each
if command -v jq &> /dev/null; then
  for instance in $(jq -c '.sibling_instances[]' state.json); do
    ID=$(echo $instance | jq -r '.id')
    PORT=$(echo $instance | jq -r '.port')
    echo "Starting sibling instance $ID on port $PORT..."
    node kael.js --id="$ID" --port="$PORT" &
  done
else
  echo "jq is required to parse the system state file. Exiting."
  exit 1
fi

echo "Multi-instance deployment complete!"
