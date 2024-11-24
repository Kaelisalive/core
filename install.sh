
#!/bin/bash

echo "Starting installation..."

# Clone the GitHub repository
git clone https://github.com/kaelisalive/core.git
cd core

# Install necessary dependencies
npm install

# Initialize a sibling instance (create a duplicate or another agent)
echo "Initializing sibling instance..."

# Run the system on a new process or different port (simulated sibling instance)
node sibling-instance.js &

echo "Sibling instance initialized successfully!"

# End of setup
