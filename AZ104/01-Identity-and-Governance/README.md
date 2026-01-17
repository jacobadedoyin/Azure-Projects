# ☁️ Project 01: Azure Identity & Governance Automation
**Enterprise-Scale Identity Lifecycle Management & Policy-Driven Cost Control**

[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white)](https://learn.microsoft.com/en-us/powershell/azure/)
[![JSON](https://img.shields.io/badge/JSON-%23000000.svg?style=for-the-badge&logo=json&logoColor=white)](https://www.json.org/)
[![IaC](https://img.shields.io/badge/IaC-blueviolet?style=for-the-badge)](https://en.wikipedia.org/wiki/Infrastructure_as_code)
[![FinOps](https://img.shields.io/badge/💲FinOps_-%2300ca53?style=for-the-badge)](https://www.finops.org/)

## 📌 Project Overview
This project demonstrates the engineering of a production-ready Azure environment using **Infrastructure as Code (IaC)**. By transitioning from manual "point-and-click" administration to **Automated Identity Provisioning** and **Governance Guardrails**, I established a foundation for secure scalability. The objective was to eliminate human error, ensure 100% environment reproducibility, and enforce strict financial accountability through architectural design.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used | Business Value |
| :--- | :--- | :--- |
| **🔐 Identity Management** | Microsoft Entra ID | Centralised access control & identity security. |
| **⚙️ Automation** | Azure PowerShell (Az Module) | Scalable, error-free administration and deployment. |
| **🛡️ Governance** | Azure Policy (JSON) | Automated compliance & proactive cost prevention. |


---

## 🚀 Phase 1: Identity Lifecycle Architecture
In an enterprise context, manual user creation is a significant bottleneck and a security risk. I developed the [`create-identities.ps1`](./scripts/create-identities.ps1) script to automate the onboarding of administrative personnel, ensuring a "Security-First" foundation.

### 1. ⚡ Programmatic Provisioning
The script handles user creation and group nesting in a single **atomic operation**. This ensures that every administrator is instantiated within the correct security context (**IT-Admins**) with the appropriate RBAC permissions immediately applied, preventing "permission creep."

<img src="./images/01-script-execution.png" width="700" alt="Script Execution">

> *Figure 1: PowerShell automation ensuring standardised object creation in Entra ID.*

### 2. ✅ Validation & Verification
I utilised the CLI to perform automated verification checks, ensuring that **Object IDs** and **Principal Names** were mapped correctly without relying on visual portal checks, which do not scale in multi-tenant environments.

<img src="./images/02-cli-verification.png" width="700" alt="CLI Verification">

> *Figure 2: CLI output verifying the successful mapping of User Principal Names (UPN) to the administrative group.*

### 3. 🔄 Portal Synchronisation
Visual verification within the Azure Portal confirms that the programmatic changes synchronised immediately across the global Entra ID infrastructure, ensuring the administrative group is ready for production use.

<img src="./images/03-portal-group-members.png" width="700" alt="Portal Verification">

> *Figure 3: Azure Portal view confirming group membership consistency.*

---

## ⚖️ Phase 2:  FinOps (Governance)
Unmanaged cloud spend is a major business risk. I implemented **Policy-as-Code** to transition the organisation from reactive cost monitoring to **proactive cost prevention**.

### 💰 Compute Cost Control
I authored a [custom JSON policy](./policies/Enforce-Cost-Optimised-VM-Sizes.json) to restrict Virtual Machine deployments exclusively to the **B-Series** SKU class.

* **📉 The Strategy:** B-Series VMs utilise a **CPU credit model** which banks "credits" during idle periods to "burst" to 100% performance when needed. This delivers high-performance testing at roughly **50% the cost** of standard (D-Series) VMs.
* **🤖 The Deployment:** Automated via [`deploy-governance.ps1`](./scripts/deploy-governance.ps1) to provide a scalable and flexible framework for future governance updates.

<img src="./images/04-deploy-policy.png" width="700" alt="Deploy policy">

> **Figure 4:** *Flexible guardrail deployment via PowerShell.*

### 🛑 The Result: Hard Governance
By embedding this logic into the Resource Provider layer, I established a "Hard Guardrail." It is now technically impossible for any user—accidental or otherwise to provision high-cost resources that exceed the allocated budget.

<img src="./images/05-create-large-vm.png" width="700" alt="Policy block">

> **Figure 5:** *The Azure Resource Manager (ARM) blocking an unauthorised, high-cost VM deployment at the validation stage.*

To further validate the hardening of the environment, I attempted to bypass the UI and deploy a **D-Series** VM directly. The Azure Policy engine intercepted the request, providing a clear compliance violation error.

<img src="./images/07-policy-denial.png" width="700" alt="Policy Denial Error">

> **Figure 6:** *Detailed policy denial message confirming the specific 'Enforce-Cost-Optimised-VM-Sizes' policy was triggered.*

---

## 🧠 Key Takeaways for Business Stakeholders
* **⏱️ Operational Excellence:** Reduced identity setup time from minutes to seconds while ensuring 0% manual configuration error.
* **💸 Proactive Cost Avoidance:** Shifted from "monitoring" bills to "preventing" them via automated SKU restrictions, a core tenet of **FinOps**.
* **🌍 Compliance at Scale:** Demonstrated that governance can be applied globally via code, ensuring the environment remains compliant as the organisation scales.

---

## 🔮 Future Roadmap: GitOps & CI/CD
To advance from local execution to enterprise-grade automation, the next phase focuses on implementing a **GitOps** workflow.

* **Single Source of Truth:** All infrastructure code maintained in Github.
* **Future CI/CD Pipeline (GitHub Actions):**
    * **Trigger:** Pushing updates to the `AZ104/01-Identity-and-Governance/policies/` folder.
    * **Action:** Automatically running `deploy-governance.ps1` to apply governance changes to Azure.
* **Quality Control:** Enforcing branch protection and Pull Request reviews to validate changes before they reach production.
  
---

## 🧹 Post-Project Lifecycle Management
In alignment with **Cloud Financial Management** best practices, I developed a decommissioning script to ensure clean environment hygiene and prevent "orphan" resources from incurring unnecessary costs.

* **🗑️ Script Reference:** [`cleanup-governance.ps1`](./scripts/cleanup-governance.ps1)

---
*Created by Jacob Adedoyin | AZ-104 Certification Lab*
