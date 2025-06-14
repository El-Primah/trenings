include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

include "_vpc" {
  path   = "${dirname(find_in_parent_folders())}/_global/_vpc.hcl"
}

include "_locals" {
  path   = "${dirname(find_in_parent_folders())}/_global/_locals.hcl"
  expose = true
}

inputs = {
  cidr_block  = "${include._locals.locals.common_vars.cidr_block}"
  env         = "${include._locals.locals.common_vars.env}"
  zone        = "${include._locals.locals.common_vars.zone}"
}
