# 🏛️ Project 01:  Azure Governance & Resource Organisation
[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![Governance](https://img.shields.io/badge/Governance-Compliance-green.svg?style=for-the-badge)](https://learn.microsoft.com/en-us/azure/governance/)
[![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white)](https://learn.microsoft.com/en-us/powershell/azure/)
[![JSON](https://img.shields.io/badge/JSON-%23000000.svg?style=for-the-badge&logo=json&logoColor=white)](https://www.json.org/)

## 🎯 Project Objective
To demonstrate the ability to organise, secure, and track Azure resources using enterprise governance tools. This project ensures cloud environments remain compliant, cost-accountable, and protected from human error through automated guardrails.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used |
| :--- | :--- |
| **Cloud Platform** | Microsoft Azure |
| **Automation & IaC** | PowerShell, JSON, Azure CLI |
| **Management Layer** | Azure Resource Manager (ARM) |
| **Security & Compliance** | Azure Resource Locks, Azure Policy (Modify Effect) |
| **Governance Tools** | Resource Tagging, Inheritance Logic |

---

## 📸 Phase 1: Resource Tagging & Organisation
I implemented a standardised tagging strategy at the Resource Group level. Using key-value pairs, I categorised resources to ensure clear ownership and financial accountability for internal chargebacks.

### 1. Resource Tagging Strategy
* **Environment:** (e.g., Production, Dev, Test) - Distinguishes between resource lifecycles.
* **AccountableParty:** (e.g., Dept Name/Lead) - Identifies the primary contact for maintenance and billing.

<br>

![Resource Tagging Evidence](./images/01-group-tags.png)

> **Figure 1:** Implementation of the metadata schema on the Resource Group properties blade.

---

## 🔒 Phase 2: Resource Locks & Safety Guardrails
To transition from manual configuration to **Infrastructure as Code (IaC)**, I developed a PowerShell script  ([`apply-group-lock.ps1`](./scripts/apply-group-lock.ps1)) to apply a resource lock programmatically. This ensures the critical **'CanNotDelete'** guardrail can be applied consistently across environments, preventing accidental deletion of production assets.

### 2. Automation: Lock Deployment
The script [`apply-group-lock.ps1`](./scripts/apply-group-lock.ps1) was executed to target the resource group, instantly applying the lock without navigating the portal GUI.

<br>

![Resource Group Lock Script](./images/02-apply-lock-ps.png)
> **Figure 2:** Execution of the retrospective `apply-group-lock.ps1` script, automating the security control that was originally applied manually.

### 3. Validation: Guardrail Enforcement
To verify the lock's efficacy, I attempted to delete the Resource Group via the Azure Portal. The system correctly intercepted and blocked the request.

<br>

![Resource Group Delete Lock Test](./images/03-delete-lock-test.png)
> **Figure 3:** The Azure Portal explicitly blocking a deletion request due to the active lock.

### 4. Validation: Scope Inheritance
To test inheritance, I attempted to delete an individual storage account (`storeproof2026`). The **Azure Resource Manager (ARM)** blocked the request with a `ScopeLocked` error, proving that a parent lock successfully protects all nested child resources automatically.

<br>

<img src="./images/04-lock-inheritance-validation.png" width="500" alt="Lock Inheritance Validation">

> **Figure 4:** Evidence of lock inheritance; the sub-resource is protected by the parent scope lock.

---

## 🤖 Phase 3: Automated Policy Inheritance (IaC)
To ensure compliance at scale, I implemented **Policy as Code**. I defined the governance logic in a JSON file and deployed it using a PowerShell script, ensuring consistent application of tagging rules.



### 5. Policy Logic Definition
I created a custom policy definition that targets specific missing tags. The logic uses the **Modify** effect to inherit the `Environment` and `AccountableParty` values directly from the parent Resource Group if they are missing on child resources.


![Policy Definition Logic](./images/05-inherit-tags-policy.png)

![Policy Definition Logic](./images/05-inherit-tags-policy.1.png)

![Policy Definition Logic](./images/05-inherit-tags-policy.2.png)

> **Figure 5(s):** Deployment of .JSON policy file via PS


### 6. Validation: Automatic Inheritance
To test the automation, I deployed a new Storage Account into the Resource Group **without defining any tags manually**.

As shown below, the resource was provisioned successfully, and the **Environment** and **AccountableParty** tags were automatically populated by inheriting values from the parent Resource Group.

<br>

![Resource Auto Tags](./images/06-resource-auto-tags.png)
> **Figure 6:** The new Storage Account showing the 'Production' and 'AccountableParty' tags were applied automatically during deployment.

### 7. Technical Validation (Activity Log)
To confirm this was performed by the Azure Policy engine (and not a default setting), I inspected the **Activity Log**.

The log entry for the storage account creation confirms a **'Policy Action'** event occurred. The operation status **'Succeeded'** proves that the **Modify** effect intercepted the deployment request and injected the missing metadata in real-time.

<br>

![Activity Log Proof](./images/07-activitylog-storage-tag-inheritance.png)
> **Figure 7:** The Activity Log explicitly showing the Policy 'Modify' event, confirming the automated remediation of the non-compliant resource.

---

## 🧠 Key Cloud Concepts Covered
* **Governance:** Using **Azure Policy** to enforce standards (tagging) rather than relying on manual discipline.
* **Infrastructure as Code (IaC):** Defining policy logic in **JSON** and deploying it via **PowerShell**, ensuring repeatability.
* **Hierarchy & Inheritance:** Leveraging the Resource Group as a "parent" container to cascade settings down to "child" resources.
* **Remediation:** Using the **Modify** effect to automatically fix non-compliant resources during deployment (active governance) rather than just blocking them.

---

---

## 🧹 Maintenance & Cleanup
To maintain environment hygiene and avoid unnecessary costs, the following decommission steps were performed:

1. **Governance Removal:** The `CanNotDelete` lock was removed and the Azure Policy assignment was deleted to allow for clean resource removal.
2. **Resource Decommissioning:** The entire `RG-Governance-Lab` was deleted, which programmatically terminated all nested storage and networking assets.
3. **Verification:** Confirmed via the Activity Log that all resources were successfully purged.

```powershell
# Final Cleanup Command
Remove-AzResourceGroup -Name "RG-Governance-Lab" -Force
