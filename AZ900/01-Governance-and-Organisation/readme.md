# Project 01: Azure Governance & Resource Organisation

🎯 **Objective** To demonstrate the ability to organise, secure, and track Azure resources using enterprise governance tools. This project ensures cloud environments remain compliant, cost-accountable, and protected from human error.

---

## 📸 Governance Evidence

### 1. Resource Tagging
I implemented a tagging strategy at the Resource Group level to track costs by department and environment. This metadata allows for precise billing and clear resource ownership tracking across the subscription.

![Resource Tagging](images/resource-group-tags.png)

### 2. Resource Locks
I applied a **'CanNotDelete'** lock to the Resource Group. This serves as a critical safety guardrail, preventing the accidental deletion of production assets—a key principle of the Azure Well-Architected Framework.

**Validation Test:** The image below demonstrates the lock in action, showing the Azure Resource Manager (ARM) blocking a manual deletion attempt.

![Lock Deletion Test](images/delete-lock-test.png)

### 3. Resource Group Organisation
This view shows the logical grouping of resources within the 'Overview' pane. By expanding the **Essentials** section, we can verify the region (UK South) and the active tags in a single unified view.

![Resource Group Overview](images/resource-group-overview.png)

---

## 🛠️ Advanced Governance: Automated Inheritance
To ensure 100% compliance, I deployed a custom **Azure Policy** (see [inherit-tags-policy.json](./inherit-tags-policy.json)) using the **Modify** effect. This policy automates the inheritance of the `Environment` and `AccountableParty` tags from the Resource Group to any child resource.



**Policy Validation Test:**
To validate the policy, I deployed a test storage account (`tagpolicytestaz900`) without adding any tags during the setup process. As shown in the evidence below, the Azure Policy successfully intercepted the deployment and applied the required organizational tags automatically.

![Policy Inheritance Validation](images/tag-policy-validation.png)

---

## 💡 Key AZ-900 Concepts Covered
* **Resource Groups:** Serving as a logical container for lifecycle management.
* **Azure Resource Manager (ARM):** The underlying service used to apply tags and locks via JSON-based definitions.
* **Tags:** Metadata used for cost center allocation, security categorization, and organization.
* **Locks:** Protecting resources from accidental modification or deletion (ReadOnly and CanNotDelete).
* **Azure Policy:** Implementing automated guardrails at scale to enforce corporate standards and remediate non-compliant resources.
