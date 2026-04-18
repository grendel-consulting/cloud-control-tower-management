provider "aws" {
  region = var.ct_home_region
}

provider "tfe" {
  hostname = var.tfc_hostname
  token    = var.tfc_token
}

terraform {
  required_version = "1.14.8" # Needs to match TFC version

  cloud {
    organization = "grendel-consulting"
    workspaces {
      name = "cloud-control-tower-management"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "0.76.2"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.2.1"
    }
  }
}
