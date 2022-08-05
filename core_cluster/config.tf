terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}


# Help provider to create helm charts
provider "helm" {
  debug = true
  kubernetes {
    host                   = module.aks.aks_host
    client_key             = base64decode(module.aks.aks_client_key)
    client_certificate     = base64decode(module.aks.aks_client_certificate)
    cluster_ca_certificate = base64decode(module.aks.aks_ca_certificate)
  }
}

# Use kubernetes provider to provision K8S cluster and it's resources
provider "kubernetes" {
  host                   = module.aks.aks_host
  client_key             = base64decode(module.aks.aks_client_key)
  client_certificate     = base64decode(module.aks.aks_client_certificate)
  cluster_ca_certificate = base64decode(module.aks.aks_ca_certificate)
}

# Cloudflare provider to add A record for load balancer IP
provider "cloudflare" {
}
