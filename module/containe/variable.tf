variable "containers" {
  description = "Map of Cosmos DB container configurations"
  type        = map(object({
    rgname        = string
    dbaccountname = string
    dbname        = string
    partition_key_paths = list(string)
  }))
  default     = {}
  
}