cluster_version = "1.21.7"

cluster_admin_group_ids = [
  "d5075d0a-3704-4ed9-ad62-dc8068c7d0e1" # aks-administrator
]

virtual_network_cidrs = [
  "10.244.0.0/14"
]

virtual_network_subnets = [
  { cidr = "10.246.0.0/16", name = "aks" },
  { cidr = "10.247.2.0/27", name = "app-gw" }
]
