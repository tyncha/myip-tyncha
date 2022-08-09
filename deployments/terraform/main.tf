

module "myip_deploy" {
  source                 = "fuchicorp/chart/helm"
  deployment_name        = "myip"
  deployment_environment = var.deployment_environment
  deployment_endpoint    = "${var.deployment_endpoint[var.deployment_environment]}.${var.google_domain_name}"
  deployment_path        = "./charts/myip"
  enabled                = "true"
  version                = "0.0.12"  
  template_custom_vars  = {
    deployment_image        = var.deployment_image
  }               
}
