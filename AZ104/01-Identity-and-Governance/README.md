# ☁️ Project 1: Azure Identity & Governance Automation

[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white)](https://learn.microsoft.com/en-us/powershell/azure/)
[![JSON](https://img.shields.io/badge/JSON-%23000000.svg?style=for-the-badge&logo=json&logoColor=white)](https://www.json.org/)

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
The script handles user creation (`New-AzADUser`) and group membership assignment (`Add-AzADGroupMember`) in a single execution flow, reducing manual entry errors.
<br>
![Script Execution](./images/01-script-execution.png)
> **Figure 1:** PowerShell output showing the successful creation of the user and group objects.

### 2. CLI Membership Verification
Using `Get-AzADGroupMember` to programmatically confirm that the **Jacob Admin** identity is correctly nested within the administrative group.

![CLI Verification](./images/02-cli-verification.png)
> **Figure 2:** Verifying the Object ID and User Principal Name (UPN) are correctly mapped in Entra ID.

### 3. Entra ID Portal Confirmation
Visual verification within the Azure Portal confirming the user status and group membership.
<br>
<img src="./images/03-portal-group-members.png" width="500" alt="Portal Verification">

> **Figure 3:** Azure Portal view of the 'IT-Admins' group members, confirming the sync was immediate.

---

## ⚖️ Phase 2: Governance & Cost Control

### 4. Policy as Code: Cost Optimization
I implemented a comprehensive governance solution using **Infrastructure as Code (IaC)**.

* **Definition:** Authored a [custom JSON definition](./policies/Enforce-Cost-Optimised-VM-Sizes.json) to restrict VM sizes to the **B-Series** family.
* **Automation:** Developed a [PowerShell deployment script](./scripts/deploy-governance.ps1) to programmatically define and assign this policy to the Resource Group, ensuring repeatable enforcement without manual clicking.

![Policy Deployment](./images/04-policy-deploy.png)
> **Figure 4:** Execution of the PowerShell script to deploy and assign the cost governance policy.

### 🔍 Validation: Testing the Guardrails
To verify the guardrails were active, I attempted to provision a high-performance **D-Series** VM, which falls outside the allowed SKU list.

**1. Scope Restriction**
Upon opening the VM size selector, the policy enforcement was immediately visible. The interface indicated that resource selection was being restricted by the `Enforce-Small-VM` assignment, effectively filtering the available options.

![VM Size Scope](./images/05-vm-size-scope.png)


> **Figure 5:** The VM sizing blade showing D-Series sizes are grayed out or hidden.
<br>
**2. Policy Identification**
The portal explicitly identified the `Enforce-Small-VM` policy assignment as the reason for the restriction, providing immediate feedback to the user.

<br>

![Policy Assignment Proof](./images/06-policy-assignment.png)
> **Figure 6:** Error details explicitly citing the 'Enforce-Small-VM' policy assignment as the blocker.

**3. Deployment Block**
As final proof of enforcement, the system prevented the deployment with a **"Blocked by Policy"** status.
<br>
![Policy Denial Error](./images/07-policy-denial.png)
> **Figure 7:** The "Validation Failed" error message, confirming it is impossible to bypass the control.

### 🔑 Key Observations
* **Proactive Filtering:** The policy filtered the list of available VM sizes *before* I could even select one, saving time and preventing configuration errors.
* **Hard Governance:** The system enforced a hard stop with a clear "Blocked by Policy" notification, ensuring strict adherence to the budget.

---
*Created by Jacob Adedoyin | Azure 104 Cloud Administration Portfolio*
