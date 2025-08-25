# Phase 3 script
cat << 'EOF' > phase3_webserver.sh
#!/bin/bash
# Phase 3: Web Server Enhancements

set -e

echo "=== Updating system ==="
sudo apt update && sudo apt upgrade -y

echo "=== Installing Nginx ==="
sudo apt install nginx -y

echo "=== Deploying static site ==="
SITE_DIR="/var/www/mysite"
if [ ! -d "$SITE_DIR" ]; then
    sudo mkdir -p $SITE_DIR
    echo "<h1>Hello from Phase 3 Static Site</h1>" | sudo tee $SITE_DIR/index.html
    sudo chown -R www-data:www-data $SITE_DIR
    sudo chmod -R 755 $SITE_DIR
fi

echo "=== Configuring Nginx server block ==="
NGINX_CONF="/etc/nginx/sites-available/mysite"
if [ ! -f "$NGINX_CONF" ]; then
    sudo tee $NGINX_CONF > /dev/null <<EOL
server {
    listen 80;
    server_name mysite.local;

    root /var/www/mysite;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOL
    sudo ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/
    sudo nginx -t
    sudo systemctl restart nginx
fi

echo "=== Phase 3 complete: Static site and server block ready ==="
EOF
