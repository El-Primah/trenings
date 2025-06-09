include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

include "_nlb" {
  path   = "${dirname(find_in_parent_folders())}/_global/_nlb.hcl"
}

dependency "compute" {
  config_path  = "../compute"

  mock_outputs = {
    instance_ip   = "12345"
  }
}

dependency "vpc" {
  config_path  = "../vpc"

  mock_outputs = {
    network_id  = "12345"
    subnet_id   = "12345"
  }
}

include "_locals" {
  path   = "${dirname(find_in_parent_folders())}/_global/_locals.hcl"
  expose = true
}

inputs = {
  region       = "${include._locals.locals.common_vars.region}"
  instance_ip  = "${dependency.compute.outputs.instance_ip}"
  subnet_id    = "${dependency.vpc.outputs.subnet_id}"
  network_id   = "${dependency.vpc.outputs.network_id}"
  zone         = "${include._locals.locals.common_vars.zone}"
  env          = "${include._locals.locals.common_vars.env}"
}
