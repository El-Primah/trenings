include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform  {
  source = "${dirname(find_in_parent_folders())}/modules/psql"
}

dependency "vpc" {
  config_path  = "../vpc"

  mock_outputs = {
    network_id  = "12345"
    subnet_id   = "12345"
  }
}

include "_locals" {
  path = "${dirname(find_in_parent_folders())}/_global/_locals.hcl"
  expose = true
}

inputs = {
  network_id  = "${dependency.vpc.outputs.network_id}"
  subnet_id   = "${dependency.vpc.outputs.subnet_id}"
  zone        = "${include._locals.locals.common_vars.zone}"
  env         = "${include._locals.locals.common_vars.env}"
}