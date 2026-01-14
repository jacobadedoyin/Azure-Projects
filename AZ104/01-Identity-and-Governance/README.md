# ☁️ Project 1: Azure Identity & Governance Automation
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

### 4. Policy as Code: Cost Optimization
I authored a custom Azure Policy JSON definition to enforce cost governance. This policy acts as a guardrail, ensuring that only cost-effective **B-Series** virtual machines (Standard_B1s and Standard_B1ms) can be deployed.



**Deployment & Troubleshooting Workflow:**
To deploy the policy, I synchronized the GitHub repository with the **Azure Cloud Shell** and executed the deployment via PowerShell.

```powershell
# Read and Register the Policy Definition
$policyJson = Get-Content -Raw "./Enforce-Cost-Optimised-VM-Sizes.json"
$definition = New-AzPolicyDefinition -Name "Enforce-Cost-Optimised-VM-Sizes" `
                                     -DisplayName "Enforce Cost-Optimised VM Sizes" `
                                     -Policy $policyJson
