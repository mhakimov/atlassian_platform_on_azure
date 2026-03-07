# atlassian_platform_on_azure

Build a production-style Azure Kubernetes cluster **step by step**.

This project demonstrates how to create and evolve a Kubernetes platform on **Azure Kubernetes Service (AKS)** using **Terraform**, without overwhelming complexity. Each branch introduces a **single new concept**, allowing you to progress from a simple deployment to a more complete platform.

--- 
## Secure Jira

**Secure Jira** is a self-hosted Jira solution running on **Azure Kubernetes Service (AKS)**, designed for organisations that cannot use SaaS tools like Jira Cloud, and require strict compliance, data sovereignty, and enterprise-grade security.


## Business scenario features:

- Full Jira functionality in a self-managed environment  
- Deployment on **Azure AKS** for scalability and reliability  
- Enterprise-grade security and compliance ready  
- Configurable for internal networks and private access  
- Ideal for highly regulated industries 

The example workload is **Jira**, but the cluster is designed so you can easily run **any application** with minimal changes.

---

## Learning Philosophy

Kubernetes platforms can feel overwhelming. Instead of dumping a full production setup in one repository, this project teaches AKS **progressively**:

1. Start with a minimal cluster
2. Deploy a real application
3. Gradually add platform capabilities
4. Learn each concept in isolation

Each **branch represents a learning stage**.

You can explore the project sequentially without being buried in Kubernetes complexity.

---

## Branch Structure

| Branch | What you learn |
|------|----------------|
| `10-lb-deploy` | Minimal AKS cluster + Jira deployment exposed via a public LoadBalancer |

More stages coming soon as the platform evolves.

---

## ⚙️ Technologies

- Terraform
- Azure Kubernetes Service (AKS)
- Kubernetes
- Helm
- Jira (example workload)

---

## 🚧 Current Stage

The repository currently starts with:

**`10-lb-deploy`**

A minimal AKS cluster where Jira is deployed and exposed via a **public Azure Load Balancer**.

This is the simplest possible starting point for running an application on AKS.

---

## How to Use This Repository

1. Start with the first branch
2. Deploy the infrastructure
3. Understand the concept introduced
4. Move to the next branch

```
replaces old context:
az aks get-credentials \
  --resource-group rg-terraform-atlassian \
  --name aks-atlassian-platform \
  --overwrite-existing \
  --admin



kubectl create secret generic jira-secrets \
  --from-literal=DB_USER=jirauser \
  --from-literal=DB_PASSWORD=S4lamdonya \
  --from-literal=DB_HOST=pg-atlassian.postgres.database.azure.com


kubectl apply -f jira-pvc.yaml

kubectl apply -f jira-deployment.yaml

kubectl apply -f jira-lb.yaml
```
git checkout 10-lb-deploy
```

---



---

