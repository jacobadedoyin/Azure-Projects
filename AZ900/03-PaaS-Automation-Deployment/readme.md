# 🌐 Azure Static Web Apps & CI/CD Automation
[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-%232088FF.svg?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/features/actions)
[![PaaS](https://img.shields.io/badge/Architecture-PaaS-orange.svg?style=for-the-badge)](https://learn.microsoft.com/en-us/azure/static-web-apps/overview)

## 🎯 Project Objective
To demonstrate the deployment of a **Platform as a Service (PaaS)** solution and the implementation of a modern **CI/CD (Continuous Integration/Continuous Deployment)** pipeline using GitHub Actions.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used |
| :--- | :--- |
| **Cloud Service** | Azure Static Web Apps (PaaS) |
| **Automation** | GitHub Actions |
| **Version Control** | Git / GitHub |
| **Deployment Flow** | Continuous Deployment (CD) |
| **Global Reach** | Content Delivery Network (CDN) |

---

## 🚀 Phase 1: The DevOps Workflow
Unlike traditional web hosting, this project uses a "Push-to-Deploy" model. By linking Azure directly to this GitHub repository, I created an automated lifecycle where code changes are verified and deployed without manual intervention.



### 1. GitHub Actions Pipeline
Every commit to the `main` branch triggers an automated build. This screenshot confirms the successful execution of the deployment workflow, demonstrating operational agility and reduced human error.

![GitHub Actions Success](images/github-actions-success.png)

---

## 💻 Phase 2: Application Hosting (PaaS)
By leveraging **Platform as a Service**, I eliminated the need for server management, OS patching, and web server configuration. This allows the business to focus strictly on the application code while Azure handles the underlying infrastructure.



### 2. Azure Portal Resource Management
This view confirms the Static Web App status and reflects the abstraction of the environment. Azure natively handles the scaling and high availability of the site.

![Azure Portal View](images/azure-portal-resource-view.png)

<br>

### 3. Live Site Production Preview
The final HTML application is hosted on Azure's global infrastructure. It is served via a Global CDN, ensuring low latency and high performance for users regardless of their geographic location.

![Website Preview](images/website-deployment-preview.png)

---

## 🧠 Key Cloud Concepts Covered
* **PaaS (Platform as a Service):** Zero server management. Microsoft manages the hardware, OS, and runtime, significantly reducing operational overhead compared to IaaS.
* **Agility & Automation:** Using **GitHub Actions** to enable faster update cycles and consistent deployment environments.
* **Global Distribution:** Utilizing a **CDN (Content Delivery Network)** to demonstrate the cloud's **Global Reach** and **High Availability**.
* **Cost Efficiency:** Transitioning from "always-on" VMs to serverless static hosting to optimize cloud spend.

---

## 🧹 Post-Project Cleanup
In accordance with **Cloud Cost Management** best practices, all resources were decommissioned immediately after documentation to prevent unnecessary billing.

---
*Created by Jacob Adedoyin-Griffiths | Azure DevOps & Cloud Portfolio*
