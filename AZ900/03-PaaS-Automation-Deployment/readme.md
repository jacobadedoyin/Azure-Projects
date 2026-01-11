# Project 03: Azure Static Web Apps (PaaS & CI/CD)

## 🎯 Objective
To demonstrate the deployment of a **Platform as a Service (PaaS)** solution and the implementation of a **CI/CD (Continuous Integration/Continuous Deployment)** pipeline using GitHub Actions.

## 📸 Deployment Evidence

### 1. Live Site Preview
This is the final web application hosted on Azure's global infrastructure. By using PaaS, I focused only on the code while Azure managed the web server.
![Website Preview](website-deployment-preview.png)

### 2. GitHub Actions CI/CD Pipeline
Every time I pushed code to this repository, GitHub Actions automatically triggered a build and deployed the changes to Azure.
![GitHub Actions Success](github-actions-success.png)

### 3. Azure Portal Resource Management
Confirmation of the Static Web App resource within the Azure Portal.
![Azure Portal View](azure-portal-resource-view.png)

---

## 💡 AZ-900 Concepts Demonstrated

### ☁️ PaaS (Platform as a Service)
Unlike my previous VM project (IaaS), this project required **zero server management**. Microsoft handles the OS patching, hardware, and web server (IIS/Nginx) configuration.

### 🚀 Automation & Dev Ops
I utilized **GitHub Actions** to create a seamless link between my source code and the cloud. This demonstrates the "Agility" and "Scalability" benefits of the cloud.

### 🌍 Global Reach
Static Web Apps are automatically distributed to edge locations worldwide, ensuring high availability and low latency for users regardless of their location.

---

## 🧹 Post-Project Cleanup
To follow **Cloud Cost Management** best practices, this resource was decommissioned after the successful deployment and documentation was completed.
