# Terraform Azure Core Infrastructure

### Project Overview
This repository contains the first phase of a modular infrastructure project focused on automated cloud provisioning within restricted subscription environments (**Azure for Students**). It utilizes **Terraform** to architect a standardized Linux environment on **ARM-based** hardware, prioritizing high-uptime, cost-efficiency, and Infrastructure as Code (IaC) best practices.

### Core Objectives
* **Infrastructure as Code (IaC):** Eliminate manual "Click-Ops" by automating the entire lifecycle of a cloud web server.
* **Architecture Alignment:** Specifically targeting **Ampere Altra (ARM64)** processors to bypass x86_64 capacity shortages and policy restrictions in the `centralindia` region.
* **State Reconciliation:** Implementing manual state imports to recover from partial deployment failures and maintain a "Single Source of Truth" in the `.tfstate` file.

### Infrastructure Components
* **Networking:** Provisioning of a dedicated Virtual Network (**VNet**) and a high-availability **Subnet** (`snet-web`).
* **Security:** Implementation of a **Network Security Group (NSG)** with strict inbound rules, permitting traffic only on **Port 80 (HTTP)** and **Port 22 (SSH)**.
* **Compute:** Deployment of an **Ubuntu 22.04 LTS (ARM64)** instance using the `Standard_B2pts_v2` SKU.
* **Automation:** Zero-touch bootstrapping via `custom_data` scripts to automate **Nginx** installation and local `src/index.html` injection immediately upon instance launch.

---

### Technical Stack
* **Cloud Provider:** Microsoft Azure
* **IaC Tool:** Terraform v1.x
* **Region:** Central India (`centralindia`)
* **Instance SKU:** `Standard_B2pts_v2` (ARM64)
* **OS Image:** `Canonical:0001-com-ubuntu-server-jammy:22_04-lts-arm64:latest`
* **Web Server:** Nginx (Stable)

---

### Deployment & Recovery Workflow

#### 1. Initialization & State Sync
In restricted tiers, resources often "orphan" after failed runs. Use the following sync pattern to reconcile the environment:

```bash
# Initialize providers
terraform init

# If resources already exist in Azure, import them to local state:
terraform import azurerm_resource_group.rg /subscriptions/<sub_id>/resourceGroups/rg-terraform-azure-core
terraform import azurerm_virtual_network.vnet /subscriptions/<sub_id>/resourceGroups/rg-terraform-azure-core/providers/Microsoft.Network/virtualNetworks/vnet-core
terraform import azurerm_subnet.subnet /subscriptions/<sub_id>/resourceGroups/rg-terraform-azure-core/providers/Microsoft.Network/virtualNetworks/vnet-core/subnets/snet-web
terraform import azurerm_public_ip.pip /subscriptions/<sub_id>/resourceGroups/rg-terraform-azure-core/providers/Microsoft.Network/publicIPAddresses/pip-web-server
