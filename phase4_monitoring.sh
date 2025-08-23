# Phase 4 script
cat << 'EOF' > phase4_monitoring.sh
#!/bin/bash
# Phase 4: Operations & Monitoring

set -e

echo "=== Updating system ==="
sudo apt update && sudo apt upgrade -y

echo "=== Ensuring logrotate config for Nginx ==="
if [ -f /etc/logrotate.d/nginx ]; then
    echo "Nginx logrotate config already exists."
else
    sudo tee /etc/logrotate.d/nginx > /dev/null <<EOL
/var/log/nginx/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 0640 www-data adm
    sharedscripts
    postrotate
        [ -f /run/nginx.pid ] && kill -USR1 \$(cat /run/nginx.pid)
    endscript
}
EOL
    echo "Nginx logrotate config created."
fi

echo "=== Installing monitoring tools ==="
sudo apt install -y htop glances net-tools

echo "=== Quick systemd + log check ==="
sudo systemctl status nginx --no-pager || true
sudo journalctl -u nginx --since "10 minutes ago" | tail -n 5 || true

echo "=== Phase 4 complete: Monitoring ready ==="
EOF
