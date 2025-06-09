include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform  {
  source = "${dirname(find_in_parent_folders())}/modules/compute"
}

dependency "vpc" {
  config_path  = "../vpc"

  #mock_outputs = {
   # subnet_id   = "12345"
  #}
}

include "_locals" {
  path = "${dirname(find_in_parent_folders())}/_global/_locals.hcl"
  expose = true
}

inputs = {
  subnet_id    = "${dependency.vpc.outputs.subnet_id}"
  zone         = "${include._locals.locals.common_vars.zone}"
  env          = "${include._locals.locals.common_vars.env}"
  ssh_key_file = file(find_in_parent_folders("${include._locals.locals.common_vars.ssh_key_file}"))
}