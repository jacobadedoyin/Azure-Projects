# 🏛️ Azure Governance & Resource Organization
[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![Governance](https://img.shields.io/badge/Governance-Compliance-green.svg?style=for-the-badge)](https://learn.microsoft.com/en-us/azure/governance/)

## 🎯 Project Objective
To demonstrate the ability to organize, secure, and track Azure resources using enterprise governance tools. This project ensures cloud environments remain compliant, cost-accountable, and protected from human error through automated guardrails.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used |
| :--- | :--- |
| **Cloud Platform** | Microsoft Azure |
| **Management Layer** | Azure Resource Manager (ARM) |
| **Security & Compliance** | Azure Resource Locks, Azure Policy |
| **Governance Tools** | Resource Tagging, Inheritance Logic |
| **Region** | UK South |

---

## 📸 Phase 1: Resource Tagging & Organization
I implemented a standardized tagging strategy at the Resource Group level. Using key-value pairs, I categorized resources to ensure clear ownership and financial accountability for internal chargebacks.



### 1. Resource Tagging Strategy
* **Environment:** (e.g., Production, Dev, Test) - Distinguishes between resource lifecycles.
* **AccountableParty:** (e.g., Dept Name/Lead) - Identifies the primary contact for maintenance and billing.

![Resource Tagging Evidence](images/resource-group-tags.png)

<br>

### 2. Resource Group Architecture
This view shows the logical grouping of resources. By expanding the **Essentials** section, we verify the region (UK South) and the active tags in a single unified view.

![Resource Group Overview](images/resource-group-overview.png)

---

## 🔒 Phase 2: Resource Locks & Safety Guardrails
I applied a **'CanNotDelete'** lock to the Resource Group. This serves as a critical safety guardrail, preventing accidental deletion of production assets—a key principle of the **Azure Well-Architected Framework**.



### 3. Validation: Resource Group Level
The system blocks any manual attempt to delete the entire Resource Group container.

![Resource Group Lock Test](images/delete-lock-test.png)

<br>

### 4. Validation: Scope Inheritance
To test inheritance, I attempted to delete an individual storage account (`storeproof2026`). The **Azure Resource Manager (ARM)** blocked the request with a `ScopeLocked` error, proving that a parent lock successfully protects all nested child resources.

![Lock Inheritance Validation](images/lock-inheritance-validation.png)

---

## 🤖 Phase 3: Automated Policy Inheritance
To ensure 100% compliance, I deployed a custom **Azure Policy** using the **Modify** effect. This effect actively remediates non-compliant resources by injecting required tags during the deployment phase.

### 5. Policy Assignment
The policy was assigned to the `RG-Governance-Lab` scope, specifically targeting tag inheritance across all resource types.

![Policy Assignment Proof](images/assign-policy.png)

<br>

### 6. Technical Validation (Activity Log)
The Azure Activity Log confirms the **Modify** action was successfully triggered during the creation of a test storage account. This proves the policy intercepted the request and enforced the organizational tags.

![Policy Activity Log Proof](images/policy-activity-log.png)

<br>

### 7. Final Remediation Result
Even though tags were omitted during the manual setup, the account now carries the inherited metadata required for corporate billing.

![Policy Tag Validation](images/tag-policy-validation.png)

---

## 🧠 Key Cloud Concepts Covered
* **Resource Groups:** Logical containers for lifecycle management.
* **ARM Templates:** Applying tags and locks via JSON-based definitions.
* **Metadata Management:** Using Tags for cost center allocation and security.
* **Inheritance:** Leveraging scope-level locks to protect child resources.
* **Policy Remediation:** Automating governance at scale using the **Modify** effect.

---
*Created by Jacob Adedoyin-Griffiths | Azure Cloud Portfolio*
