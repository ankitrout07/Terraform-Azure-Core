Project Overview
This repository contains the first phase of a modular infrastructure project focused on automated cloud provisioning. It utilizes Terraform to architect and deploy a standardized Linux environment on Microsoft Azure. The project automates the creation of a secure virtual network and the deployment of an Ubuntu-based web server with a pre-configured Nginx service.

Core Objectives
The primary goal is to automate the lifecycle of a cloud-based web server, moving away from manual console configuration toward Infrastructure as Code (IaC) to prioritize speed, accuracy, and repeatability.

Infrastructure Components
Networking: Provisioning of a dedicated Virtual Network (VNet) and Subnet to isolate resources.

Security: Implementation of a Network Security Group (NSG) with strict inbound rules, permitting traffic only on Port 80 (HTTP) and Port 22 (SSH).

Compute: Deployment of an Ubuntu 22.04 LTS Virtual Machine instance.

Automation: Bootstrapping via custom_data shell scripts to automate Nginx installation and service activation immediately upon instance launch.

Technical Stack
Cloud Provider: Microsoft Azure

Infrastructure as Code: Terraform

Operating System: Ubuntu 22.04 LTS

Web Server: Nginx

Deployment Instructions
Initialize Terraform:

Bash
terraform init
Apply Configuration:

Bash
terraform apply -auto-approve
Validation:
Verify the web server is reachable by running:

Bash
curl -I $(terraform output -raw public_ip_address)