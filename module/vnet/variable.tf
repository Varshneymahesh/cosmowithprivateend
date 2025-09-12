variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "subnets" {
  description = "Map of subnet configurations"
  type        = map(any)
  default     = {}
}

variable "rgname" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}