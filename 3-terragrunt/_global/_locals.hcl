locals {
  common_vars = yamldecode(file(find_in_parent_folders("env.yaml")))
}