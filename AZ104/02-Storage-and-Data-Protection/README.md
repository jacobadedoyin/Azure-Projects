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
I leveraged the **Azure CLI** to programmatically provision the storage infrastructure, enforcing strict redundancy standards (LRS) and regional data residency (UK South).

### 1. Storage Account Provisioning
**Resource Creation:** Deployed a **Standard_LRS General Purpose v2** storage account, chosen for its balance of high durability and cost-efficiency for archive workloads.

![Storage Creation](./images/01-create-storage.png)
> *Figure 1: Bash to create Storage Account via Azure CLI.*

### 2. Container Security & Isolation
**Data Segregation:** Architected a dedicated `data-archive` container to isolate sensitive compliance records from general application logs.
**Zero-Trust Authentication:** Instead of using insecure Storage Account Keys, I used the `--auth-mode login` flag. This enforces **Microsoft Entra ID** authentication, ensuring that only identities with specific RBAC roles can manipulate the data plane.

![Container Creation](./images/02-create-container.png)
> *Figure 2: Creation of the container using Entra ID authentication.*

### 3. Deployment Validation
**Portal Verification:** Confirmed the resource health, location, and replication settings via the Azure Portal.

![Portal View](./images/05-portal-storage-resource.png)
> *Figure 3: Operational status verified in the Azure Portal.*

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
