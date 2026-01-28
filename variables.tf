variable "xo_url" {
  description = "URL of the Xen Orchestra instance (e.g., wss://xo.example.com)"
  type        = string
}

variable "xo_username" {
  description = "Username for Xen Orchestra authentication"
  type        = string
}

variable "xo_password" {
  description = "Password for Xen Orchestra authentication"
  type        = string
  sensitive   = true
}

variable "pool_id" {
  description = "The ID of the pool where resources will be created"
  type        = string
}

variable "template_name" {
  description = "The name of the VM template to clone"
  type        = string
}

variable "sr_name" {
  description = "The name of the Storage Repository (SR) to use for the VM disk"
  type        = string
}

variable "network_name" {
  description = "The name of the network to attach to the VM (e.g., 'Pool-wide network associated with eth0')"
  type        = string
}
