# Project 03: 🌐 Azure Static Web Apps & CI/CD Automation

<a href="https://azure.microsoft.com/en-us/services/static-web-apps/"><img src="https://img.shields.io/badge/☁️_PAAS_ARCHITECTURE-0072C6?style=for-the-badge&logo=microsoftazure&logoColor=white" height="50"></a>
<a href="https://github.com/features/actions"><img src="https://img.shields.io/badge/_CI/CD_AUTOMATION-2088FF?style=for-the-badge&logo=githubactions&logoColor=white" height="50"></a>
<a href="https://en.wikipedia.org/wiki/Serverless_computing"><img src="https://img.shields.io/badge/⚡_SERVERLESS_HOSTING-00ca53?style=for-the-badge&logo=azure-functions&logoColor=white" height="50"></a>
<a href="https://www.finops.org/"><img src="https://img.shields.io/badge/💲_TCO_REDUCTION-E95420?style=for-the-badge&logo=square-terminal&logoColor=white" height="50"></a>

## 🎯 Project Objective
To demonstrate the deployment of a **Platform as a Service (PaaS)** solution and the implementation of a modern **CI/CD (Continuous Integration/Continuous Deployment)** pipeline. This project focuses on accelerating the **Developer Velocity** by automating the release cycle and leveraging serverless architecture for global scalability.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used |
| :--- | :--- |
| **Cloud Service** | Azure Static Web Apps (PaaS) |
| **Automation** | GitHub Actions |
| **Version Control** | Git / GitHub |
| **Deployment Flow** | Continuous Deployment (CD) |
| **Global Reach** | Azure Content Delivery Network (CDN) |

---

## 🚀 Phase 1: Automated DevOps Lifecycle
To eliminate manual deployment bottlenecks, I implemented a "Push-to-Deploy" model. By integrating Azure Static Web Apps with the GitHub repository, I established a **Production-Ready CI/CD pipeline** that ensures consistency between the source code and the live environment.



### 1. GitHub Actions Pipeline Orchestration
Every commit to the `main` branch triggers an automated workflow. This process validates the code and synchronizes changes to the cloud automatically, significantly reducing the **Time-to-Market** and minimising human error during deployments.

<br>

![GitHub Actions Success](images/github-actions-success.png)
> **Figure 1:** Successful execution of the GitHub Actions workflow, demonstrating automated build and deployment jobs.

---

## 💻 Phase 2: Serverless Application Hosting (PaaS)
By adopting a **Platform as a Service (PaaS)** model, I offloaded the "Undifferentiated Heavy Lifting"-OS patching, web server maintenance, and hardware management to Microsoft Azure. This architectural choice allows for maximum focus on application logic and user experience.

### 2. Managed Infrastructure Overview
The Azure Static Web App resource acts as a managed endpoint. Because it is serverless, it provides **Native High Availability** and **Auto-Scaling**, ensuring the application remains responsive during traffic spikes without manual intervention.

<br>

![Azure Portal View](images/azure-portal-resource-view.png)
> **Figure 2:** Azure Resource Management view, showcasing the direct link between the cloud environment and source control.

### 3. Global Distribution & Edge Performance
The application is deployed across Azure’s **Global Content Delivery Network (CDN)**. By caching content at "Edge locations" closer to the end-user, the architecture minimises latency and provides a high-performance experience on a global scale.

<br>

![Website Preview](images/website-deployment-preview.png)
> **Figure 3:** The live production environment, verified and accessible via a globally distributed URL.

---

## 🧠 Key Cloud Governance Concepts
* **PaaS Efficiency:** Leveraged managed services to achieve **Zero-Touch Maintenance**, reducing the total cost of ownership (TCO).
* **Operational Excellence:** Utilized **GitHub Actions** to enforce standardised deployment workflows.
* **Global Reach:** Demonstrated the ability to host content at the **Network Edge** for improved performance and reliability.
* **Serverless Cost Optimization:** Shifted from "Always-on" IaaS costs to a PaaS consumption model, optimising cloud spend for static workloads.

---

## 🧹 Post-Project Lifecycle Management
In alignment with **Cloud Financial Management (FinOps)** best practices, all project resources were decommissioned following validation to eliminate unnecessary costs and ensure clean environment hygiene.

---
*Created by Jacob Adedoyin | Azure 900 Portfolio*
