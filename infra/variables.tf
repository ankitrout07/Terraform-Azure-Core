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

variable "admin_ip_cidr" {
  description = "The CIDR block allowed to SSH into the VM"
  type        = string
  default     = "2401:4900:8fe2:3795:8162:21f3:645d:10da" # Your current IP. Can change to 0.0.0.0/0 to open it entirely.
}