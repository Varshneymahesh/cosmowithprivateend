variable "subnets" {
    description = "Map of subnet configurations"
    type        = map(object({
        subnetname      = string
        rgname         = string
        vnetname       = string
        address_prefixes = list(string)
    }))
    default     = {}
  
}