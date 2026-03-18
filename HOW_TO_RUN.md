# How to Run This Terraform Project

This document provides instructions on how to deploy the Terraform code in this project.

## Prerequisites

Before you begin, ensure you have the following software installed on your machine:

*   [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
*   [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

You will also need an active Azure subscription.

## Configuration

1.  **Log in to Azure:**

    Open a terminal and run the following command to log in to your Azure account:

    ```bash
    az login
    ```

2.  **Configure Terraform Variables:**

    This project uses variables to define the resource group name, location, and VM size. You can set these variables in a `terraform.tfvars` file or by passing them as command-line arguments.

    Create a file named `terraform.tfvars` with the following content:

    ```hcl
    resource_group_name = "rg-terraform-azure-core"
    location            = "East US"
    vm_size             = "Standard_DS1_v2"
    ```

    You can choose a different location and VM size based on your requirements.

## Execution

1.  **Initialize Terraform:**

    Open a terminal in the root directory of this project and run the following command to initialize Terraform:

    ```bash
    terraform init
    ```

2.  **Plan the Deployment:**

    Run the following command to see the execution plan:

    ```bash
    terraform plan
    ```

3.  **Apply the Configuration:**

    Run the following command to deploy the resources:

    ```bash
    terraform apply -auto-approve
    ```

## Verification

After the `terraform apply` command completes successfully, you can verify the deployment by:

1.  **Checking the Azure Portal:**

    Log in to the Azure portal and navigate to the resource group you created. You should see the virtual machine, virtual network, and other resources.

2.  **Accessing the Web Server:**

    Find the public IP address of the virtual machine in the output of the `terraform apply` command or by looking at the `azurerm_public_ip` resource in the Azure portal. Open a web browser and navigate to `http://<public-ip-address>`. You should see the "Hello, World!" message from the `src/index.html` file.

## Cleanup

To destroy the resources created by this project, run the following command:

```bash
terraform destroy -auto-approve
```
