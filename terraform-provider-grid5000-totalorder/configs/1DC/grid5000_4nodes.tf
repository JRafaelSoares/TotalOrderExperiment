locals {
  site        = "nancy"
  nodes_count = 4
  selectors = ["C", "S", "B", "M"]
}

resource "grid5000_job" "my_job1" {
  name      = "Terraform RKE"
  site      = local.site
  command   = "sleep 24h"
  resources = "/nodes=${local.nodes_count}"
  properties = "cluster='gros'"
  types     = ["deploy"]
}

resource "grid5000_deployment" "my_deployment" {
  site        = local.site
  environment = "debian10-x64-base"
  nodes       = grid5000_job.my_job1.assigned_nodes
  key         = file("~/.ssh/id_rsa.pub")
}

