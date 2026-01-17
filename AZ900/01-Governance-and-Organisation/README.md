# 🏛️ Project 01: Azure Governance & Resource Organisation

[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![Governance](https://img.shields.io/badge/Governance-Compliance-green.svg?style=for-the-badge)](https://learn.microsoft.com/en-us/azure/governance/)
[![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white)](https://learn.microsoft.com/en-us/powershell/azure/)
[![JSON](https://img.shields.io/badge/JSON-%23000000.svg?style=for-the-badge&logo=json&logoColor=white)](https://www.json.org/)

## 🎯 Project Objective
To design and implement a rigid governance framework that automates compliance, ensures financial accountability, and protects critical assets from human error. This project demonstrates the transition from manual administration to **Policy-as-Code** and **Automated Guardrails**.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used | Business Value |
| :--- | :--- | :--- |
| **Cloud Platform** | Microsoft Azure | Enterprise-grade infrastructure hosting. |
| **Automation** | PowerShell, JSON, Azure CLI | Repeatable, error-free deployment of standards. |
| **Security** | Azure Resource Locks | Prevention of accidental data loss/downtime. |
| **Governance** | Azure Policy (Modify Effect) | Automated remediation of non-compliant resources. |
| **FinOps** | Resource Tagging | Accurate chargeback and cost center tracking. |

---

## 📸 Phase 1: Resource Tagging & Financial Accountability
I implemented a standardised tagging taxonomy at the Resource Group level. Using key-value pairs, I categorised resources to ensure clear ownership and enable granular billing reports.

### 1. Tagging Taxonomy Strategy
* **Environment:** (e.g., `Production`, `Dev`) - Separates lifecycles for cost analysis.
* **AccountableParty:** (e.g., `Jacob Adedoyin`) - Identifies the primary owner for operational maintenance.

<br>

![Resource Tagging Evidence](./images/01-group-tags.png)

> **Figure 1:** Implementation of the metadata schema on the Resource Group properties blade.

---

## 🔒 Phase 2: Resource Locks & Safety Guardrails
To transition from manual configuration to **Infrastructure as Code (IaC)**, I developed a PowerShell script ([`apply-group-lock.ps1`](./scripts/apply-group-lock.ps1)) to apply a resource lock programmatically. This ensures the critical **'CanNotDelete'** guardrail is enforced consistently across environments.

### 2. Automation: Lock Deployment
The script was executed to target the resource group, instantly applying the lock without the risk of manual GUI errors.

<br>

![Resource Group Lock Script](./images/02-apply-lock-ps.png)
> **Figure 2:** Execution of the `apply-group-lock.ps1` script, automating the security control application.

### 3. Validation: Guardrail Enforcement
To verify the lock's efficacy, I attempted to delete the Resource Group via the Azure Portal. The **Azure Resource Manager (ARM)** correctly intercepted and blocked the request.

<br>

![Resource Group Delete Lock Test](./images/03-delete-lock-test.png)
> **Figure 3:** The Azure Portal explicitly blocking a deletion request due to the active lock.

### 4. Validation: Scope Inheritance
To test inheritance logic, I attempted to delete an individual storage account (`storeproof2026`) located *inside* the locked group. The system blocked the request with a `ScopeLocked` error
