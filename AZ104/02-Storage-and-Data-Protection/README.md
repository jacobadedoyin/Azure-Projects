# 📦 Project 02: Storage & Data Protection

[![Azure Storage](https://img.shields.io/badge/Azure_Storage-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://learn.microsoft.com/en-us/azure/storage/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)


## 🎯 Project Objective
To architect a secure, compliant infrastructure foundation combining **Immutable Storage (WORM)** for data governance and **Azure Container Instances (ACI)** for rapid, serverless application hosting. This project demonstrates the ability to manage the full data lifecycle while deploying ephemeral compute resources without the overhead of Virtual Machines.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used | Business Value |
| :--- | :--- | :--- |
| **Storage Services** | Azure Blob Storage (GPv2) | Scalable, tiered cloud storage. |
| **Compute** | Azure Container Instances (ACI) | "NoOps" serverless application hosting. |
| **Governance** | Immutable Policies (WORM) | Ransomware protection & legal compliance. |
| **Automation** | Azure CLI (Bash) | Rapid, repeatable deployment. |
| **Security** | Entra ID (RBAC) | Zero-trust identity management. |

---

## 🚀 Phase 1: Infrastructure Deployment (Storage) REDOOOOOOOOOOOOO
I leveraged the **Azure CLI** ⌨️ to programmatically provision the storage infrastructure, enforcing strict **Data Residency** (UK South 🇬🇧) and utilising **Infrastructure as Code (IaC)** 📜 principles for repeatability.

* **📂 Script Reference:** [`deploy-storage.sh`](./scripts/deploy-storage.sh)

### 1. 💾 Storage Account Provisioning
**🏗️ Resource Strategy:** Deployed a **Standard_LRS General Purpose v2** account. I selected GPv2 specifically because it is the only account type that supports the required **Lifecycle Management** and **Access Tiering** (Hot 🔥 / Cool ❄️ / Archive 🧊) features needed for this project.

<img src="./images/01-create-storage.png" width="700" alt="Storage Creation">

> *Figure 1: Execution of the Azure CLI script to provision the storage resource.*

### 2. 🔒 Container Security & Isolation
I implemented a multi-layered security approach for the data plane:

* **🧱 Data Segregation:** Architected a dedicated `data-archive` container. This provides a logical isolation boundary, separating sensitive compliance records from standard application logs.
* **🛡️ Identity-Based Security (Zero Trust):** Instead of using insecure Storage Account Keys 🔑 (which provide broad admin access), I utilised the `--auth-mode login` flag. This enforces **Microsoft Entra ID** 👤 verification, ensuring that only identities with explicit RBAC roles can interact with the storage container.

<img src="./images/02-create-container.png" width="700" alt="Container Creation">

> *Figure 2: Container creation utilising Entra ID authentication for Zero Trust security.*

### 3. ✅ Deployment Validation
**🩺 Health Check:** Verified the resource properties in the Azure Portal to confirm that the **Locally Redundant Storage (LRS)** 🔁 replication and region settings were applied correctly.

<img src="./images/03-storage-validation.png" width="700" alt="Portal View">

> *Figure 3: Visual confirmation of the Storage Account status in the Azure Portal.*

---

## ⚖️ Phase 2: Compliance & Data Governance
In this phase, I enforced strict data retention guardrails to simulate a real-world financial compliance environment.

### Immutability (WORM) Implementation
I applied a **Time-Based Retention Policy** to the `data-archive` container to ensure data integrity.

* **Configuration:** Configured a rigid retention period of **180 days**.
* **Impact (WORM):** This enforces **"Write Once, Read Many"** compliance. It strips all users, including Global Administrators, of the ability to overwrite or delete blobs until the retention timer expires, ensuring an unalterable audit trail and protection against ransomware.
* **Resource Locking:** Applied a `CanNotDelete` management lock to the Resource Group level to prevent accidental deletion of the control plane.

<img src="./images/04-immutability-policy.png" width="700" alt="Immutability Policy">

> *Figure 4: CLI output confirming the Immutability Policy is active. Note the `immutabilityPeriodSinceCreationInDays: 180`.*

---

## 💸 Phase 3: Cost Optimization & Automation
To proactively manage cloud OpEx and prevent "Data Sprawl," I implemented an automated lifecycle engine to handle data aging without manual intervention.

### JSON-Defined Lifecycle Policy
I defined the business logic in a custom JSON configuration file ([`Data-Aging-and-Cost-Optimisation-Policy.json`](./policies/Data-Aging-and-Cost-Optimisation-Policy.json)) and applied it programmatically via the Azure CLI.

<img src="./images/05-lifecycle-policy.png" width="700" alt="Lifecycle Policy JSON">

> *Figure 5: CLI output confirming the successful injection of the JSON policy definition.*

**Tiering Logic:**
* **Move to Cool Tier (30 Days):** Targets data accessed infrequently. This reduces storage costs by ~45% while keeping data instantly available.
* **Move to Archive Tier (90 Days):** Transitions cold data to offline storage for long-term retention at the lowest possible price point.
* **Auto-Delete (2555 Days / 7 Years):** Automatically purges records once the regulatory retention period expires to free up capacity.

<img src="./images/06-portal-lifecycle-rule.png" width="700" alt="Portal Lifecycle Rule">

> *Figure 6: Azure Portal visualization of the "Hot → Cool → Archive" data flow.*

---

## 🐳 Phase 4: Serverless Compute (ACI)
To demonstrate modern application hosting, I extended the infrastructure by deploying a microservice using **Azure Container Instances (ACI)**. Unlike VMs, ACI allows for running Docker containers directly on the Azure fabric without managing the underlying OS.

### 1. Ephemeral Deployment
I executed an atomic Azure CLI command to provision the container. This "Fire and Forget" model resulted in a running application in under 45 seconds.

* **Image Source:** `mcr.microsoft.com/azuredocs/aci-helloworld` (Public Registry)
* **Configuration:** `Standard` SKU with minimal resource footprint (1 CPU, 1.5 GB RAM) to minimize run costs.

<img src="./images/07-aci-deploy.png" width="700" alt="ACI Deployment Command">

> *Figure 7: Deploying the container instance via CLI with a public DNS label.*

### 2. Public Accessibility
I configured a custom DNS name label (`acilab-jacob.uk-south.azurecontainer.io`) to expose the application to the public internet via port 80, verifying successful TCP connectivity.

<img src="./images/08-aci-running.png" width="700" alt="ACI Hello World">

> *Figure 8: Verification of the running application accessible via the custom FQDN.*

---

## 📈 Business Impact & Summary
By architecting this solution, I achieved:
* **Legal Compliance:** Met regulatory standards for non-erasable data (WORM).
* **Operational Efficiency:** Automated data aging, reducing manual admin work by 100%.
* **Speed to Market:** Demonstrated how ACI can deploy applications in seconds compared to the minutes/hours required for VM provisioning.

---

## 🔧 Troubleshooting & Lessons Learned
* **Resource Providers:** Encountered a `SubscriptionNotFound` error. Resolved by manually registering the `Microsoft.Storage` provider via CLI.
* **JSON Parsing:** Learned that referencing external JSON files in CLI requires careful formatting (`@filename.json`) to avoid parsing errors.
* **Name Conflicts:** ACI requires globally unique DNS labels within the region. I updated my script to append a random string to the DNS label to ensure successful deployment.

---

## 🧹 Clean-up & Maintenance
To prevent ongoing costs, I performed the following cleanup steps:
1. **Unlocked Resources:** Removed the `CanNotDelete` lock from the Resource Group.
2. **Resource Deletion:** Deleted the `AZ104-Lab` group to purge all storage and compute assets.
3. **Policy Cleanup:** Removed the custom policy definitions created during the lab.

---
*Created by Jacob Adedoyin | Azure 104 Cloud Administration Portfolio*
