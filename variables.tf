variable "resource_group_name" {
  default = "rg-terraform-azure-core"
}

variable "location" {
  default = "centralindia"
}

variable "vm_size" {
  default = "Standard_B2pts_v2"
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    Project     = "Terraform-Azure-Core"
    Environment = "Production"
    Owner       = "Ankit"
    ManagedBy   = "Terraform"
  }
}