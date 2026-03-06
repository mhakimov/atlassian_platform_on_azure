# resource "azurerm_public_ip" "ingress_ip" {
#   name                = "jira-ingress-ip"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# resource "helm_release" "nginx_ingress" {
#   name       = "nginx-ingress"
#   repository = "https://kubernetes.github.io/ingress-nginx"
#   chart      = "ingress-nginx"
#   # namespace  = "ingress-nginx"
#   namespace = "jira"
#   # create_namespace = true
#   create_namespace = false


#   # timeout = 600 # seconds, 10 min
#   # wait    = true
#   timeout = 0
#   wait    = false

#   values = [
#     yamlencode({
#       controller = {
#         service = {
#           loadBalancerIP = azurerm_public_ip.ingress_ip.ip_address
#           annotations = {
#             "service.beta.kubernetes.io/azure-load-balancer-resource-group" = azurerm_resource_group.rg.name
#           }
#         }
#         config = {
#           whitelist-source-range = join(
#             ",",
#             [for ip in var.allowed_ips : "${ip}/32"]
#           )
#         }
#       }
#     })
#   ]
# }

# output "aks_principal_id" {
#   value = azurerm_kubernetes_cluster.aks.identity[0].principal_id
# }
