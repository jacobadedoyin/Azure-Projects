# 📦 Project 02: Storage Compliance & Data Lifecycle Automation

[![Azure Storage](https://img.shields.io/badge/Azure_Storage-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://learn.microsoft.com/en-us/azure/storage/)
[![Azure CLI](https://img.shields.io/badge/Azure_CLI-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://learn.microsoft.com/en-us/cli/azure/)
[![Compliance](https://img.shields.io/badge/Compliance-WORM-green?style=for-the-badge)](https://learn.microsoft.com/en-us/azure/storage/blobs/immutable-storage-overview)

## 🎯 Project Objective
To architect a secure, compliant storage solution that enforces **Data Residency** and **Regulatory Retention**. This project demonstrates the implementation of **Immutable Storage (WORM)** for legal holds and **Automated Lifecycle Management** to programmatically reduce cloud spend by moving aging data to Archive tiers.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used |
| :--- | :--- |
| **Storage Services** | Azure Blob Storage (GPv2), Containers |
| **Governance** | Immutable Policies (WORM), Resource Locks |
| **Automation** | Azure CLI (Bash), JSON Lifecycle Rules |
| **Security** | Role-Based Access Control (RBAC), Entra ID Auth |

---

## 🚀 Phase 1: Infrastructure Deployment
I leveraged the **Azure CLI** to programmatically provision the storage infrastructure, enforcing strict **Data Residency** (UK South) and utilizing **Infrastructure as Code (IaC)** principles for repeatability.

### 1. Storage Account Provisioning
**Resource Strategy:** Deployed a **Standard_LRS General Purpose v2** account. I selected GPv2 specifically because it is the only account type that supports the required **Lifecycle Management** and **Access Tiering** (Hot/Cool/Archive) features needed for this project.

![Storage Creation](./images/01-create-storage.png)
> *Figure 1: Execution of the Azure CLI script to provision the storage resource.*

### 2. Container Security & Isolation
I implemented a multi-layered security approach for the data plane:

* **Data Segregation:** Architected a dedicated `data-archive` container. This provides a logical isolation boundary, separating sensitive compliance records from standard application logs to prevent accidental exposure.
* **Identity-Based Security (Zero Trust):** Instead of using insecure Storage Account Keys (which provide broad admin access), I utilized the `--auth-mode login` flag. This enforces **Microsoft Entra ID** verification, ensuring that only identities with explicit RBAC roles can interact with the storage container.

![Container Creation](./images/02-create-container.png)
> *Figure 2: Container creation utilizing Entra ID authentication for Zero Trust security.*

### 3. Deployment Validation
**Health Check:** Verified the resource properties in the Azure Portal to confirm that the **Locally Redundant Storage (LRS)** replication and region settings were applied correctly.

![Portal View](./images/03-storage-validation.png)
> *Figure 3: Visual confirmation of the Storage Account status in the Azure Portal.*
---

## ⚖️ Phase 2: Compliance & Data Governance
In this phase, I enforced strict data retention rules to simulate a financial or healthcare compliance scenario.

### 2. Immutability (WORM) Policy
I applied a **Time-Based Retention Policy** to the `data-archive` container.
* **Configuration:** Locked data for **180 days**.
* **Impact:** Prevents any user (including Administrators) from modifying or deleting blobs until the retention period expires, satisfying "Write Once, Read Many" requirements.



---

## 💸 Phase 3: Cost Optimization & Automation
To prevent "Data Sprawl," I implemented an automated policy to manage the data lifecycle without human intervention.

### 3. JSON Lifecycle Management
I defined a custom JSON policy (`Data-Aging-and-Cost-Optimisation-Policy`) to transition data tiers:
* **Cool Tier:** Moves blobs after **30 days** (Lower retrieval costs).
* **Archive Tier:** Moves blobs after **90 days** (Lowest storage costs).
* **Deletion:** Purges data after **7 years (2555 days)**.

![Lifecycle Policy JSON](./images/04-lifecycle-policy.png)
![Portal Lifecycle Visual](./images/06-portal-lifecycle-rule.png)

---

## 🔧 Troubleshooting & Lessons Learned
* **Resource Providers:** Encountered a `SubscriptionNotFound` error. Resolved by manually registering the `Microsoft.Storage` provider via CLI.
* **JSON Parsing:** Learned that referencing external JSON files in CLI requires careful formatting (`@filename.json`) to avoid parsing errors.
* **CLI Context:** Discovered the importance of `az account set` when working with multiple subscriptions to ensure resources deploy to the correct billing scope.

---
*Created by Jacob Adedoyin-Griffiths | Azure Cloud Administration Portfolio*
