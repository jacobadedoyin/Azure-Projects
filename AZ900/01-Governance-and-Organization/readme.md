# Project 01: Azure Governance & Resource Organization

## 🎯 Objective
To demonstrate the ability to organize, secure, and track Azure resources using governance tools.

## 📸 Governance Evidence

### 1. Resource Tagging
I implemented a tagging strategy to track costs by department and environment.
![Resource Tags](resource-tags.png)

### 2. Resource Locks
I applied a 'CanNotDelete' lock to the storage account to prevent accidental deletion of critical data—a key part of the Azure Well-Architected Framework.
![Resource Lock](resource-lock-active.png)

### 3. Resource Group Organization
This shows the logical grouping of resources, allowing for unified lifecycle management (deleting the group deletes everything inside).
![Resource Group View](resource-group-hierarchy.png)

---

## 💡 Key AZ-900 Concepts Covered
- **Resource Groups:** Acting as a logical container for resources.
- **Azure Resource Manager (ARM):** The deployment and management service for Azure.
- **Tags:** Metadata used for cost center allocation and organization.
- **Locks:** Protecting resources from accidental modification or deletion.
