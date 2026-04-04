#!/bin/bash
set -e

echo "Gathering infrastructure outputs..."
# Run within infra directory since state is there
cd "$(dirname "$0")/../infra"
IP=$(terraform output -raw web_server_public_ip)
cd - > /dev/null

if [ -z "$IP" ]; then
    echo "Error: Could not retrieve Public IP from Terraform. Is the infrastructure deployed?"
    exit 1
fi

echo "Deploying Application Payload to $IP..."
# Copy the app payload to the Nginx root directory over SSH
scp -v -o StrictHostKeyChecking=no -r $(dirname "$0")/../app/* azureuser@$IP:/var/www/html/

echo "✅ Deployment complete! Visit http://$IP to see your modular dashboard."
