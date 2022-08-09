variable "google_bucket_name" {}

variable "google_project_id" {}


variable "deployment_name" {}

variable "credentials" {
    default = "google-credentials.json"
}





variable "deployment_image" { default = "fuchicorp/myip" }

variable "deployment_environment" { default = "dev" }

## Deployment endpoint for the application
variable "deployment_endpoint" {
    type = map(string)
     default = {
        test  = "test.myip"
        dev  = "dev.myip"
        qa   = "qa.myip"
        prod = "myip"
        stage = "stage.myip"
  }
  description = "(Optional)- Application endpoint."
}

variable "google_domain_name" { default = "fuchicorp.com" }


variable "myip" {
  type = map(string)

  default = {
    enabled = "false"
  }
   description = "-(Optional) Myip map configuration."
}

output "endpoint" {
  value = "${var.deployment_endpoint[var.deployment_environment]}.${var.google_domain_name}"
}

