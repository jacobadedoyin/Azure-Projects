# 📦 Project 02: Hybrid Storage & Automated Data Protection

[![Azure Storage](https://img.shields.io/badge/Azure_Storage-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://learn.microsoft.com/en-us/azure/storage/)
[![Backup & Recovery](https://img.shields.io/badge/Backup_&_Recovery-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://learn.microsoft.com/en-us/azure/backup/)
[![PowerShell Automation](https://img.shields.io/badge/PowerShell-Automation-blue.svg?style=for-the-badge&logo=powershell)](https://learn.microsoft.com/en-us/powershell/azure/)

## 🎯 Project Objective
To implement a secure, cost-optimized storage architecture that utilizes **Lifecycle Management** for data aging and **Recovery Services Vaults** for business continuity. This project demonstrates mastery over both unstructured (Blob) and structured (File) storage tiers while enforcing strict "WORM" (Write Once, Read Many) compliance and automated recovery guardrails.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used |
| :--- | :--- |
| **Storage Services** | Azure Blob Storage, Azure Files |
| **Data Protection** | Recovery Services Vault (RSV), Azure Backup |
| **Security** | Shared Access Signatures (SAS), Immutable Storage |
| **Automation** | PowerShell Lifecycle Policies, AzCopy |
| **Compliance** | Time-based Retention Policies |

---

## 🚀 Phase 1: Storage Infrastructure & Security
I provisioned a **General Purpose v2 (GPv2)** storage account and implemented granular access controls to minimize the attack surface.

### 1. Granular Access: Shared Access Signatures (SAS)
Instead of using account-wide Access Keys, I generated a **User-Delegated SAS** with restricted permissions (Read-only) and a 24-hour expiration window. This adheres to the **Principle of Least Privilege** by ensuring the token cannot be used for unauthorized modifications or long-term access.



### 2. Networking & Service Endpoints
To prevent data exposure to the public internet, I restricted the Storage Account to specific **Virtual Networks** using **Service Endpoints**. This ensures that only authorized subnets can reach the data layer, effectively isolating the storage from external threats.

---

## ❄️ Phase 2: Cost Optimization & Compliance
Managing cloud spend is a primary duty for AZ-104 admins. I implemented automated data tiering to reduce storage costs significantly.

### 3. Automated Lifecycle Management
I authored a lifecycle rule that automatically transitions blobs between tiers based on last access time:
* **Hot to Cool:** After 30 days of inactivity.
* **Cool to Archive:** After 90 days of inactivity.
* **Deletion:** After 180 days (for temporary logs).



### 4. Immutable Blob Storage (Compliance)
For regulatory requirements, I configured a **Time-based Retention Policy** at the container level. This "Locks" the data, preventing any user (including Global Admins) from deleting or modifying the blobs for a set period.

---

## 🛡️ Phase 3: Business Continuity (Data Protection)
Infrastructure is only as good as its last backup. I implemented a centralized backup strategy for core IaaS assets.

### 5. Recovery Services Vault (RSV) Setup
I deployed a Recovery Services Vault with **Geo-Redundant Storage (GRS)** enabled. This ensures that even if an entire Azure Region goes offline, our backup data remains resilient and accessible in the paired region.



### 6. Azure VM & File Share Backup
* **VM Backup:** Configured a daily backup policy with a 14-day retention period.
* **File Share Snapshot:** Implemented automated snapshots for Azure Files to allow for individual file recovery without full-share restoration.



---

## 🧠 Key Admin Concepts Covered
* **Storage Redundancy:** Understanding the trade-offs between **LRS, ZRS,** and **GRS**.
* **Secure Access:** Moving away from Access Keys to **SAS** and **Entra ID-based RBAC**.
* **RPO/RTO:** Defining recovery point objectives via backup schedules and replication tiers.
* **Data Migration:** Using the **AzCopy** utility for high-speed data migration into Azure.

---
*Created by Jacob Adedoyin-Griffiths | Azure Cloud Administration Portfolio*
