variable "rgname" {
  description = "Name of the Resource Group"
  type        = string
  
}
variable "location" {
  description = "Azure region for resources"
  type        = string
  
}

variable "endpointname" {
  description = "Name of the Private Endpoint"
  type        = string
  
}
variable "subnetid" {
  description = "ID of the Subnet"
  type        = string
  
}
variable "private_connection_resource_id" {
  description = "The resource ID of the Cosmos DB account to which the private endpoint will connect"
  type        = string
}