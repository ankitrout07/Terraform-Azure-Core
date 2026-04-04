# 🚀 Infrastructure Dashboard: Deployment Guide

This document provides high-uptime instructions for deploying the **Modular Azure Core** infrastructure and the associated production dashboard.

## 🛠 Prerequisites

Ensure your local environment (**NTZ-LINUX-003**) is ready:
* **Terraform v1.4+**
* **Azure CLI v2.0+**
* **OpenSSH Client** (for automated file syncing)

## 🏗 Configuration

1. **Azure Authentication:**
   ```bash
   az login
   ```

2. **Environment Variables:**
   The project is pre-configured for **Central India** using **ARM64** VM sizes. Create a `terraform.tfvars` to override defaults if necessary:
   ```hcl
   resource_group_name = "rg-terraform-azure-core"
   location            = "Central India"
   vm_size             = "Standard_B1ps" # ARM64 Architecture
   ```

## 🚀 Execution

1. **Initialize & Sync:**
   Navigate to the infra directory, download providers and initialize the backend.
   ```bash
   cd infra
   terraform init
   ```

2. **Validate & Plan:**
   Always verify the execution plan to prevent configuration drift.
   ```bash
   terraform plan
   ```

3. **Provision Infrastructure:**
   Deploy the VNet, NSG, Storage Account, and VM.
   ```bash
   terraform apply -auto-approve
   ```



---

## 📦 Application Deployment (Phase 2 Modular)

Infrastructure alone only gives you a blank server. Run these steps to deploy the **Production Dashboard** assets.

1. **Get the Public IP:**
   ```bash
   IP=$(terraform output -raw web_server_public_ip)
   ```

2. **Execute Deployment Script:**
   We use a decoupled sync strategy to ensure CSS and JS are placed in their modular directories. Note: Run this from the root of the project.
   ```bash
   ./scripts/deploy.sh
   ```

## 🔍 Verification

1. **Health Check:**
   Verify the Nginx service is responding with our modular payload:
   ```bash
   curl -I http://$(terraform output -raw web_server_public_ip)
   ```

2. **Browser Access:**
   Navigate to `http://<web_server_public_ip>`. 
   * **Expected Result:** A dark-themed dashboard showing **Architecture: ARM64** and **Region: Central India**.
   * **Console Check:** Press `F12` and verify the message: `Production Dashboard Loaded Successfully.`

## 🧹 Infrastructure Lifecycle (Cleanup)

To avoid unnecessary Azure costs, tear down the environment when finished:

```bash
# WARNING: This action is destructive and removes all provisioned resources.
terraform destroy -auto-approve
```

---

**Next Step:** Since your `terraform.tfstate` is currently sitting in your local sidebar, would you like me to help you add the **Remote Backend** block to your `providers.tf` so your state is safely stored in the `storage.tf` container?