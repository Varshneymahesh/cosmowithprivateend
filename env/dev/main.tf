module "rg" {
  source = "../../module/rg"
  rgname = "cosmo-rg"
  location = " centralindia"
  
}
module "vnet" {
  source = "../../module/vnet"
  # Parameter Definition for the Azure Network Foundation components
    rgname =     "cosmo-rg"
    location = "centralindia"                                 
    vnet_name = "cosmo-vnet"
    address_space = ["10.0.0.0/16"]
    depends_on = [ module.rg ]
}
  
module "subnet" {
  source = "../../module/subnet"
  subnets = {
    "cosmo-subnet" = {
       subnetname  = "cosmo-subnet"
      rgname = module.rg.rgname
      vnetname = module.vnet.vnet_name
      address_prefixes = ["10.0.1.0/24"]

  },
    "cosmo-subnet-2" = {
       subnetname = "cosmo-subnet-2"
      rgname = module.rg.rgname
      vnetname = module.vnet.vnet_name
      address_prefixes = ["10.0.2.0/24"]
  },
   "cosmo-subnet-3" = {
        subnetname= "cosmo-subnet-3"
      rgname = module.rg.rgname
      vnetname = module.vnet.vnet_name
      address_prefixes = ["10.0.3.0/24"]
  },
  
    
}
depends_on = [ module.vnet ]
}


module "cosmo_account" {
    source = "../../module/cosmosaccount"
    dbaccountname = "cosmowithprivateend"
    rgname = module.rg.rgname
    location = "centralindia"
    public_network_access_enabled = false
    depends_on = [ module.rg, module.subnet ]
}

module "cosmo_db" {
    source = "../../module/cosmosdb"
    dbname = "cosmodb"
    dbaccountname = module.cosmo_account.accountname
    rgname = module.rg.rgname
    location = "centralindia"
    depends_on = [ module.cosmo_account ]
}

module "container" {
    source = "../../module/containe"
    containers = {
      oder_err_resolver_agent = {
        rgname = module.rg.rgname
        dbaccountname = module.cosmo_account.accountname
        dbname = module.cosmo_db.dbname
        partition_key_paths = ["/orderid"]
      },
        product_catalog = {
            rgname = module.rg.rgname
            dbaccountname = module.cosmo_account.accountname
            dbname = module.cosmo_db.dbname
            partition_key_paths = ["/productid"]
    },
    backup_warehouse = {
            rgname = module.rg.rgname
            dbaccountname = module.cosmo_account.accountname
            dbname = module.cosmo_db.dbname
            partition_key_paths = ["/id"]
},
    o2i_sap_crm = {
            rgname = module.rg.rgname
            dbaccountname = module.cosmo_account.accountname
            dbname = module.cosmo_db.dbname
            partition_key_paths = ["/order_id"]
},
    o2i_sap_ecc = {
            rgname = module.rg.rgname
            dbaccountname = module.cosmo_account.accountname
            dbname = module.cosmo_db.dbname
            partition_key_paths = ["/order_id"]
    },
    o2i_sap_ecc_invetory = {
            rgname = module.rg.rgname
            dbaccountname = module.cosmo_account.accountname
            dbname = module.cosmo_db.dbname
            partition_key_paths = ["/product_id"]
    },
    customer_group = {
            rgname = module.rg.rgname
            dbaccountname = module.cosmo_account.accountname
            dbname = module.cosmo_db.dbname
            partition_key_paths = ["/customer_group"]
    }






    
    
}
depends_on = [ module.cosmo_db ]
}
module "dns-pi" {
    source = "../../module/dns_zone"
    dnszonename = "privatelink.cosmo.com"
    rgname = module.rg.rgname
  
}
module "dnslink" {
    source = "../../module/dns_link_vnet"
    dnslinkname = "vnetlink"
    rgname = module.rg.rgname
    dnszonename = module.dns-pi.dnszonename
    vnetid = module.vnet.vnet_id
    depends_on = [ module.dns-pi, module.vnet ]
    location = "centralindia"
  
}
module "private_endpoint" {
    source = "../../module/privateendpointtocosmo"
    endpointname = "cosmo-private-endpoint"
    location = "centralindia"

    rgname = module.rg.rgname
    subnetid = module.subnet.subnet_ids["cosmo-subnet-2"]
    private_connection_resource_id = module.cosmo_account.account_id
    depends_on = [ module.subnet, module.cosmo_account ]
}
