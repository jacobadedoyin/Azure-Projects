# ☁️ Project 01: Azure Identity & Governance Automation
**Enterprise-Scale Identity Lifecycle Management & Policy-Driven Cost Control**

[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white)](https://learn.microsoft.com/en-us/powershell/azure/)
[![JSON](https://img.shields.io/badge/JSON-%23000000.svg?style=for-the-badge&logo=json&logoColor=white)](https://www.json.org/)
[![IaC](https://img.shields.io/badge/IaC-Infrastructure%20As%20Code-blueviolet?style=for-the-badge)](https://en.wikipedia.org/wiki/Infrastructure_as_code)

## 📌 Project Overview
This project demonstrates the engineering of a production-ready Azure environment using **Infrastructure as Code (IaC)**. I moved away from manual "point-and-click" administration to implement **Automated Identity Provisioning** and **Governance Guardrails**. The objective was to eliminate human error, ensure 100% environment reproducibility, and enforces strict financial accountability through architectural design.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used | Business Value |
| :--- | :--- | :--- |
| **Identity Management** | Microsoft Entra ID | Centralised access control & identity security. |
| **Automation** | Azure PowerShell (Az Module) | Scalable, error-free administration and deployment. |
| **Governance** | Azure Policy (JSON) | Automated compliance & proactive cost prevention. |
| **Version Control** | Git / GitHub | Audit trails, peer review, and collaborative engineering. |

---

## 🚀 Phase 1: Identity Lifecycle Architecture
In an enterprise context, manual user creation is a significant bottleneck and a security risk. I developed the [`create-identities.ps1`](./scripts/create-identities.ps1) script to automate the onboarding of administrative personnel, ensuring a "Security-First" foundation.

### 1. Programmatic Provisioning
The script handles user creation and group nesting in a single **atomic operation**. This ensures that every administrator is born into the correct security context (**IT-Admins**) with the appropriate RBAC permissions already in place, preventing "permission creep."

<img src="./images/01-script-execution.png" width="700" alt="Script Execution">

> *Figure 1: PowerShell automation ensuring standardised object creation in Entra ID.*

### 2. Validation & Verification
I utilised the CLI to perform automated verification checks, ensuring that **Object IDs** and **Principal Names** were mapped correctly without relying on visual portal checks, which do not scale in multi-tenant environments.

<img src="./images/02-cli-verification.png" width="700" alt="CLI Verification">

> *Figure 2: CLI output verifying the successful mapping of User Principal Names (UPN) to the administrative group.*


---

## ⚖️ Phase 2: Governance & Financial Guardrails (FinOps)
Unmanaged cloud spend is a major business risk. I implemented **Policy-as-Code** to transition the organisation from reactive cost monitoring to proactive cost prevention.

### 1. Enforcing Cost-Optimised Compute
I authored a [custom JSON definition](./policies/Enforce-Cost-Optimised-VM-Sizes.json) to restrict Virtual Machine deployments to the **B-Series** family. 

* **The Architectural Result:** By embedding this logic into the resource provider layer, it is technically impossible for any user—accidental or otherwise—to provision high-cost resources that exceed the allocated budget. 

<img src="./images/04-policy-deploy.png" width="700" alt="Policy Deployment">

> *Figure 2: Deploying governance guardrails via PowerShell to ensure environment-wide compliance.*

### 🔍 Denial Proof: Testing the Guardrails
To validate the hardening of the environment, I attempted to deploy a high-performance **D-Series** VM. The Azure Policy engine intercepted the request at the **Validation Phase**, blocking the deployment before any cost was incurred.

<img src="./images/07-policy-denial.png" width="700" alt="Policy Denial Error">

> *Figure 3: Policy enforcement in action, providing "Hard Governance" against unauthorised spend.*

---

## 🧠 Key Takeaways for Business Stakeholders
* **Operational Excellence:** Reduced identity setup time from minutes to seconds while ensuring 0% manual configuration error.
* **Proactive Cost Avoidance:** Shifted from "monitoring" bills to "preventing" them via automated SKU restrictions, a core tenet of **FinOps**.
* **Compliance at Scale:** Demonstrated that governance can be applied globally via code, ensuring the environment remains compliant as the organisation scales.

---

## 🧹 Post-Project Lifecycle Management
In alignment with **Cloud Financial Management** best practices, I developed a decommissioning script to ensure clean environment hygiene and prevent "orphan" resources from incurring unnecessary costs.

* **Script Reference:** [`cleanup-governance.ps1`](./scripts/cleanup-governance.ps1)

---
*Created by Jacob Adedoyin-Griffiths | AZ-104 Certification Lab*
