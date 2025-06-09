generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "<nucket_name>"
    region = "ru-central1"
    key    = "${path_relative_to_include()}/terraform.tfstat"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true

    access_key = "<your-srvice-account-access_key>"
    secret_key = "<your-srvice-account-secret_key>"
  }
}
EOF
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("env.yaml")))
}


generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
  yandex = {
    source = "yandex-cloud/yandex"
  }
}
}  

provider "yandex" {
  cloud_id  = "${local.common_vars.cloud_id}"
  folder_id = "${local.common_vars.folder_id}"
  zone      = "${local.common_vars.zone}"
  token     = "${local.common_vars.token_path}"
}
EOF
}
