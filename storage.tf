resource "random_id" "storage_suffix" {
  byte_length = 4
}

# 2. Create the Storage Account
resource "azurerm_storage_account" "static_assets" {
  name                     = "stankit${lower(random_id.storage_suffix.hex)}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS" # Locally Redundant Storage

  # Enable the specialized 'Static Website' hosting feature
  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }

  tags = var.tags
}

# 3. Create the Container for Assets (Images, CSS, JS)
resource "azurerm_storage_container" "assets" {
  name                  = "web-assets"
  storage_account_name  = azurerm_storage_account.static_assets.name
  container_access_type = "blob" # Allow public read access for browsers
}

# 4. Automation: Sync local 'src' directory to Azure Blob Storage
resource "null_resource" "sync_frontend_assets" {
  triggers = {
    # This detects changes in ANY file inside the src directory
    dir_hash = sha1(join("", [for f in fileset("${path.module}/src", "**") : filesha1("${path.module}/src/${f}")]))
  }

  provisioner "local-exec" {
    # Uses Azure CLI to sync files. Ensure 'az' is installed on your Ubuntu machine.
    command = <<EOT
      az storage blob upload-batch \
        --account-name ${azurerm_storage_account.static_assets.name} \
        --auth-mode key \
        --destination "web-assets" \
        --source "${path.module}/src" \
        --overwrite
    EOT
  }

  # Ensure the container exists before attempting upload
  depends_on = [azurerm_storage_container.assets]
}