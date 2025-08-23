# Phase 1 script
cat << 'EOF' > phase1_setup.sh
#!/bin/bash
# Phase 1: Basic Server Setup

set -e  # Exit immediately if a command fails

echo "=== Updating system packages ==="
sudo apt update && sudo apt upgrade -y

echo "=== Creating non-root sudo user ==="
USERNAME="webadmin"
if id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME already exists."
else
    sudo adduser --gecos "" $USERNAME
    sudo usermod -aG sudo $USERNAME
    echo "User $USERNAME created and added to sudoers."
fi

echo "=== Setting up firewall (UFW) ==="
sudo apt install ufw -y
sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw --force enable

echo "=== Ensuring SSH key setup ==="
echo "Check ~/.ssh/authorized_keys for your key."
EOF
