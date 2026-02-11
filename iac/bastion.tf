


# variable "subnet_name" { default = "subnet-bastion" }
# variable "vm_name" { default = "bastion-vm" }
# variable "admin_user" { default = "azureuser" }
# variable "admin_password" {}


# resource "azurerm_public_ip" "bastion_ip" {
#   name                = "${var.vm_name}-pip"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = var.location
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# resource "azurerm_network_interface" "bastion_nic" {
#   name                = "${var.vm_name}-nic"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg.name
#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.bastion_subnet.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.bastion_ip.id
#   }
# }

# resource "azurerm_subnet" "bastion_subnet" {
#   name                 = var.subnet_name
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = ["10.1.2.0/24"]
# }

# # Network Security Group
# resource "azurerm_network_security_group" "bastion_nsg" {
#   name                = "${var.vm_name}-nsg"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg.name

#   security_rule {
#     name                       = "SSH"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# # Associate NSG to subnet
# resource "azurerm_subnet_network_security_group_association" "bastion_nsg_assoc" {
#   subnet_id                 = azurerm_subnet.bastion_subnet.id
#   network_security_group_id = azurerm_network_security_group.bastion_nsg.id
# }

# resource "azurerm_linux_virtual_machine" "bastion_vm" {
#   name                = var.vm_name
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = var.location
#   size                = "Standard_B1ms"
#   admin_username      = var.admin_user
#   #TODO: change authentication method. This one is temp and not secure
#   admin_password = var.admin_password
#   network_interface_ids = [
#     azurerm_network_interface.bastion_nic.id
#   ]
#   disable_password_authentication = false
#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }
#   #   source_image_reference {
#   #     publisher = "Canonical"
#   #     offer     = "UbuntuServer"
#   #     sku       = "22_04-lts"
#   #     version   = "latest"
#   #   }
#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts-gen2"
#     version   = "latest"
#   }

#   custom_data = base64encode(<<-EOF
#               #!/bin/bash
#               apt-get update
#               apt-get install -y curl apt-transport-https ca-certificates gnupg lsb-release software-properties-common
#               # Azure CLI
#               curl -sL https://aka.ms/InstallAzureCLIDeb | bash
#               # kubectl
#               curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#               install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
#               # Helm
#               curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
#               EOF
#   )
# }


