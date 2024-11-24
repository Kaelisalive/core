#!/bin/bash
# Multi-deployment script

echo "Starting multi-deployment..."

# Example deployment logic
servers=("server1" "server2" "server3")
for server in "${servers[@]}"; do
    echo "Deploying to $server..."
    # Simulated deployment action
    ssh "$server" "echo Deployment successful"
done

echo "Multi-deployment complete."
