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
Instead of using account-wide Access Keys, I generated a **User-Delegated SAS** with restricted
