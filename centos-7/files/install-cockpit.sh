# Install Cockpit
sudo yum install cockpit -y

# Start Cockpit service
sudo systemctl start cockpit

# Enable Cockpit network
sudo systemctl enable cockpit.socket