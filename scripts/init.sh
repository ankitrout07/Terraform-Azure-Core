#!/bin/bash
sudo apt-get update -y
sudo apt-get install nginx -y

# Enable and start the Nginx service
sudo systemctl enable nginx
sudo systemctl start nginx

# Prepare the html directory for deployment
sudo rm -f /var/www/html/index.nginx-debian.html
sudo rm -f /var/www/html/index.html

# Set permissive permissions so azureuser can deploy via SCP
sudo chown -R azureuser:azureuser /var/www/html
sudo chmod -R 755 /var/www/html
