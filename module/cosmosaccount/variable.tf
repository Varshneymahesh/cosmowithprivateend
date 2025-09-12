variable "public_network_access_enabled" {
  description = "Enable or disable public network access for Cosmos DB account"
  type        = bool
  default     = true
}
variable "dbaccountname" {
  description = "Name of the Cosmos DB account"
  type        = string
}
variable "rgname" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}
