#!/bin/bash
sudo apt-get update -y
sudo apt-get install nginx -y
sudo rm /var/www/html/index.html
echo '${index_html_content}' | sudo tee /var/www/html/index.html
sudo systemctl restart nginx
