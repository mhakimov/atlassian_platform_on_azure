# atlassian_platform_on_azure

Build a production-style Azure Kubernetes cluster **step by step**.

This project demonstrates how to create and evolve a Kubernetes platform on **Azure Kubernetes Service (AKS)** using **Terraform**, without overwhelming complexity. Each branch introduces a **single new concept**, allowing you to progress from a simple deployment to a more complete platform.

--- 
## Secure Jira

**Secure Jira** is a self-hosted Jira solution running on **Azure Kubernetes Service (AKS)**, designed for organisations that cannot use SaaS tools like Jira Cloud, and require strict compliance, data sovereignty, and enterprise-grade security.

## Business Scenario Features:

- Full Jira functionality in a self-managed environment  
- Deployment on **Azure AKS** for scalability and reliability  
- Enterprise-grade security and compliance ready  
- Configurable for internal networks and private access  
- Ideal for highly regulated industries 

The example workload is **Jira**, but the cluster is designed so you can easily run **any application** with minimal changes.

---

## Learning Philosophy

Kubernetes platforms can feel overwhelming. Instead of dumping a full production setup in one repository, this project teaches AKS progressively:

1. Start with a minimal cluster
2. Deploy a real application
3. Gradually add platform capabilities
4. Learn each concept in isolation

Each **branch represents a learning stage**.

---

## Branch Structure

| Branch | What you learn |
|------|----------------|
| `10-lb-deploy` | Minimal AKS cluster + Jira deployment exposed via a public LoadBalancer |
| `20-ingress-only` | Installed Nginx Ingress controller |

More stages coming soon as the platform evolves.

---

## Technologies

- Terraform
- Azure Kubernetes Service (AKS)
- Kubernetes
- Helm
- Jira (example workload)

---

## Current Stage

The repository currently starts with:

**`10-lb-deploy`**

A minimal AKS cluster where Jira is deployed and exposed via a **public Azure Load Balancer**.

This is the simplest possible starting point for running an application on AKS.

**`20-ingress-only`**

A minimal AKS cluster where ingress is deployed and exposed via a **public IP**.

---

## Steps to take:
```
terraform init

terraform apply

#replaces old context:
az aks get-credentials \
  --resource-group rg-terraform-atlassian \
  --name aks-atlassian-platform \
  --overwrite-existing \
  --admin


kubectl create namespace ingress-nginx

# Add the official stable repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

#Installs the NGINX Ingress Controller:
helm install nginx-ingress ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --set controller.replicaCount=2 \
  --set controller.service.type=LoadBalancer \
  --set controller.service.externalTrafficPolicy=Local \
  --set controller.service.loadBalancerIP="<INSERT_PUBLIC_STATIC_IP>"

# this parameter "--set controller.service.loadBalancerIP="REPLACE_STATIC_IP"" is optional at this stage but if you go for it then input the IP of this azurerm_public_ip.ingress_ip TF resource. 

# Access Public IP
http://<INSERT_PUBLIC_STATIC_IP>

# Expected output 
404 Not Found from Nginx

# Check Load Balancer on Azure console
Loadbalancers -> kubernetes -> Frontend IP address
```
