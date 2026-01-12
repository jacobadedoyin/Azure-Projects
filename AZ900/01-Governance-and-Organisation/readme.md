# Project 01: Azure Governance & Resource Organisation

🎯 **Objective** To demonstrate the ability to organise, secure, and track Azure resources using enterprise governance tools. This project ensures cloud environments remain compliant, cost-accountable, and protected from human error.

---

## 📸 Governance Evidence

### 1. Resource Tagging Strategy
I implemented a standardised tagging strategy at the Resource Group level. Using key-value pairs, I categorised resources to ensure clear ownership and financial accountability:

* **Environment:** (e.g. Production, Development, Test) - Used to distinguish between resource lifecycles.
* **AccountableParty:** (e.g. Name of Dept or Lead) - Used for internal chargebacks and identifying the primary contact for resource maintenance.

![Resource Tagging Evidence](images/resource-group-tags.png)

### 2. Resource Locks: Multi-Level Validation
I applied a **'CanNotDelete'** lock to the Resource Group. This serves as a critical safety guardrail, preventing the accidental deletion of production assets—a key principle of the Azure Well-Architected Framework.

**Validation 01: Resource Group Level**
The system blocks any manual attempt to delete the entire Resource Group container, ensuring the project structure remains intact.
![Resource Group Lock Test](images/delete-lock-test.png)

**Validation 02: Individual Resource Level (Inheritance)**
To test scope inheritance, I attempted to delete an individual resource (`storeproof2026`). The **Azure Resource Manager (ARM)** blocked the deletion with a `ScopeLocked` error, proving that a parent lock successfully protects all nested child resources automatically.
![Lock Inheritance Validation](images/lock-inheritance-validation.png)

### 3. Resource Group Organisation
This view shows the logical grouping of resources within the 'Overview' pane. By expanding the **Essentials** section, we can verify the region (UK South) and the active tags in a single unified view.

![Resource Group Overview](images/resource-group-overview.png)

---

## 🛠️ Advanced Governance: Automated Inheritance
To ensure 100% compliance, I deployed a custom **Azure Policy** (see [inherit-tags-policy.json](./inherit-tags-policy.json)) using the **Modify** effect. This effect actively remediates non-compliant resources by injecting the required tags during the deployment phase.

**Policy Assignment:**
The image below shows the policy successfully assigned to the `RG-Governance-Lab` scope, targeting all resource types for tag inheritance.
![Policy Assignment Proof](images/assign-policy.png)

**Technical Validation (Activity Log):**
The evidence below from the Azure Activity Log confirms the **Modify** action was successfully triggered during the creation of the `tagpolicytestaz900` storage account. This proves the policy intercepted the request and enforced the organisational tags.
![Policy Activity Log Proof](images/policy-activity-log.png)

**Final Result:**
Even though tags were omitted during the manual setup of the test resource, the account now carries the inherited metadata required for corporate billing.
![Policy Tag Validation](images/tag-policy-validation.png)

---

## 💡 Key AZ-900 Concepts Covered
* **Resource Groups:** Serving as a logical container for lifecycle management.
* **Azure Resource Manager (ARM):** The underlying service used to apply tags and locks via JSON-based definitions.
* **Tags:** Metadata used for cost centre allocation, security categorisation, and organisation.
* **Locks:** Protecting resources from accidental deletion (CanNotDelete) via scope inheritance.
* **Azure Policy:** Implementing automated guardrails at scale using the **Modify** effect for remediation.
