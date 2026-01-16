# Project 02: 📦 Storage Compliance & Data Lifecycle Automation

[![Azure Storage](https://img.shields.io/badge/Azure_Storage-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://learn.microsoft.com/en-us/azure/storage/)
[![Azure CLI](https://img.shields.io/badge/Azure_CLI-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://learn.microsoft.com/en-us/cli/azure/)
[![Bash Scripting](https://img.shields.io/badge/GNU%20Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
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
In this phase, I enforced strict data retention guardrails to simulate a real-world financial compliance environment.

### Immutability (WORM) Implementation
I applied a **Time-Based Retention Policy** to the `data-archive` container to ensure data integrity.

* **Configuration:** Configured a rigid retention period of **180 days**.
* **Impact (WORM):** This enforces **"Write Once, Read Many"** compliance. It strips all users—including Global Administrators—of the ability to overwrite or delete blobs until the retention timer expires, ensuring an unalterable audit trail.

![Immutability Policy](./images/04-immutability-policy.png)
> *Figure 4: CLI output confirming the Immutability Policy is active. Note the `immutabilityPeriodSinceCreationInDays: 180`.*


---

## 💸 Phase 3: Cost Optimization & Automation
To proactively manage cloud OpEx and prevent "Data Sprawl," I implemented an automated lifecycle engine to handle data aging without manual intervention.

### JSON-Defined Lifecycle Policy
I defined the business logic in a custom JSON configuration file ([`Data-Aging-and-Cost-Optimisation-Policy.json`](./policies/Data-Aging-and-Cost-Optimisation-Policy.json)) and applied it programmatically via the Azure CLI.


![Lifecycle Policy JSON](./images/05-lifecycle-policy.png)
> *Figure 5: CLI output confirming the successful injection of the JSON policy definition.*

**Tiering Logic:**
* **Move to Cool Tier (30 Days):** Targets data accessed infrequently. This reduces storage costs by ~45% while keeping data instantly available.
* **Move to Archive Tier (90 Days):** Transitions cold data to offline storage for long-term retention at the lowest possible price point.
* **Auto-Delete (2555 Days / 7 Years):** Automatically purges records once the regulatory retention period expires to free up capacity.

<br>

![Portal Lifecycle Visual](./images/06-portal-lifecycle-rule.png)
> *Figure 6: Azure Portal visualization of the "Hot → Cool → Archive" data flow.*
---

## 🔧 Troubleshooting & Lessons Learned
* **Resource Providers:** Encountered a `SubscriptionNotFound` error. Resolved by manually registering the `Microsoft.Storage` provider via CLI.
* **JSON Parsing:** Learned that referencing external JSON files in CLI requires careful formatting (`@filename.json`) to avoid parsing errors.
* **CLI Context:** Discovered the importance of `az account set` when working with multiple subscriptions to ensure resources deploy to the correct billing scope.

---
*Created by Jacob Adedoyin | Azure 104 Cloud Administration Portfolio*
