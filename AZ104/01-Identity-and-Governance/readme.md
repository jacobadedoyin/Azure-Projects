# ☁️ Azure Identity & Governance Automation
[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white)](https://learn.microsoft.com/en-us/powershell/azure/)

## 📌 Project Overview
This project demonstrates a production-ready setup of an Azure environment. It focuses on **Identity Lifecycle Management** and **Automated Governance**. The objective was to replace manual portal configurations with reproducible **PowerShell scripts** and **Policy as Code**.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used |
| :--- | :--- |
| **Cloud Platform** | Microsoft Azure |
| **Identity Management** | Microsoft Entra ID (Azure AD) |
| **Automation** | Azure PowerShell (Az Module) |
| **Governance** | Azure Policy (JSON Definitions) |
| **Version Control** | Git / GitHub |

---

## 🚀 Phase 1: Identity Automation
I developed the `create-identities.ps1` script to programmatically provision the **IT-Admins** security group and the **Jacob Admin** user account.

### 1. Script Execution
The script handles user creation and group membership assignment in one flow.

![Script Execution](./images/01-script-execution.png)

<br>

### 2. CLI Membership Verification
Using `Get-AzADGroupMember` to confirm that the **Jacob Admin** identity is correctly nested within the administrative group.

![CLI Verification](./images/02-cli-verification.png)

<br>

### 3. Entra ID Portal Confirmation
Visual verification within the Azure Portal confirming the user status and group membership.

![Portal Verification](./images/03-portal-group-members.png)

---

## ⚖️ Phase 2: Governance & Cost Control
To prevent budget overruns, I implemented a custom Azure Policy that restricts Virtual Machine deployments to low-cost SKUs (**Standard_B1s** and **Standard_B2s**).

### 4. Policy Deployment
The following screenshot shows the successful execution of the `deploy-governance.ps1` script, which registers the policy definition and applies it at the Subscription scope.



![Policy Deployment](./images/04-policy-deploy.png)

<br>

### 5. Policy Enforcement (Denial Proof)
To validate the guardrails, I attempted to deploy a high-cost **Standard_D2s_v3** VM. The request was successfully intercepted and blocked by the Azure Policy engine.



![Policy Denial](./images/05-policy-denial.png)

---

## 🧠 Key Takeaways
* **Efficiency:** Reduced identity setup time from minutes to seconds via automation.
* **Cost Governance:** Shifted from reactive cost monitoring to proactive prevention using Policy-as-Code.
* **Security:** Implemented a standardized naming convention and group-based access control (RBAC).

---
*Created by Jacob Adedoyin-Griffiths | AZ-104 Certification Lab*
