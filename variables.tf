variable "ct_home_region" {
  type        = string
  description = "AWS Region where AWS Control Tower is deployed"
  default     = "eu-west-1"
}

variable "tfc_hostname" {
  type        = string
  description = "Hostname of the TFC (or TFE) instance to use with AWS"
  default     = "app.terraform.io"
}

variable "tfc_organization_name" {
  type        = string
  description = "Name of your Terraform Cloud organization"
  default     = "grendel-consulting"
}

variable "tfc_project_name" {
  type        = string
  description = "Project under which the workspace exists"
  default     = "Default Project"
}

variable "tfc_workspace_name" {
  type        = string
  description = "Name of the Workspace that will connect to AWS"
  default     = "cloud-control-tower-management"
}

variable "tfc_token" {
  type        = string
  description = "Authentication token for TFC (or TFE)"
  nullable    = false
  sensitive   = true
}
