# Phase 2 script
cat << 'EOF' > phase2_security.sh
#!/bin/bash
# Phase 2: Hardening & Security

set -e

echo "=== Updating packages (security patches) ==="
sudo apt update && sudo apt upgrade -y

echo "=== Securing SSH ==="
SSHD_CONFIG="/etc/ssh/sshd_config"

sudo cp $SSHD_CONFIG ${SSHD_CONFIG}.bak
sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' $SSHD_CONFIG
sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' $SSHD_CONFIG
# sudo sed -i 's/^#Port.*/Port 2222/' $SSHD_CONFIG  # optional port change

echo "Restarting SSH service..."
sudo systemctl restart ssh

echo "=== Installing Fail2ban ==="
sudo apt install fail2ban -y

echo "=== Creating Fail2ban jail ==="
sudo tee /etc/fail2ban/jail.local > /dev/null <<EOL
[sshd]
enabled = true
port    = ssh
logpath = /var/log/auth.log
maxretry = 5
EOL

sudo systemctl restart fail2ban
sudo systemctl enable fail2ban

echo "=== Installing Certbot (HTTPS with Let's Encrypt) ==="
sudo apt install certbot python3-certbot-nginx -y
echo "To enable HTTPS, run: sudo certbot --nginx -d yourdomain.com"
EOF
