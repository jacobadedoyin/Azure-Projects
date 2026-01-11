# Project 03: Azure Static Web Apps (PaaS & CI/CD)

## 🎯 Objective
To demonstrate the deployment of a **Platform as a Service (PaaS)** solution and the implementation of a **CI/CD (Continuous Integration/Continuous Deployment)** pipeline using GitHub Actions.

## 📸 Deployment Evidence

### 1. Live Site Preview
This is the final HTML application hosted on Azure's global infrastructure. By leveraging PaaS, I removed the need for server maintenance, allowing for a focus on content delivery while Azure managed the underlying web server architecture.
![Website Preview](images/website-deployment-preview.png)

### 2. GitHub Actions CI/CD Pipeline
I established a direct link between this GitHub repository and Azure. Every time a "push" is made to the main branch, a GitHub Actions workflow is triggered to automatically build and deploy the changes, demonstrating a modern DevOps workflow.
![GitHub Actions Success](images/github-actions-success.png)

### 3. Azure Portal Resource Management
This view confirms the Static Web App resource status. It highlights the abstraction of the environment, where scaling and high availability are handled natively by the platform.
![Azure Portal View](images/azure-portal-resource-view.png)

---

## 💡 AZ-900 Concepts Demonstrated

### ☁️ PaaS (Platform as a Service)
Unlike my previous VM project (IaaS), this project required **zero server management**. Microsoft handles the OS patching, hardware, and web server configuration, which significantly reduces operational overhead.

### 🚀 Automation & DevOps
I utilized **GitHub Actions** to automate the deployment lifecycle. This reflects the "Agility" benefit of cloud computing—enabling faster updates and reducing the risk of human error during manual uploads.

### 🌍 Global Distribution
Azure Static Web Apps utilize a global content delivery network (CDN). This demonstrates the cloud's **High Availability** and **Global Reach**, as the content is served from the edge location nearest to the user.

---

## 🧹 Post-Project Cleanup
To follow **Cloud Cost Management** best practices and ensure no unnecessary resources remained, the resource was decommissioned upon completion of this documentation.
