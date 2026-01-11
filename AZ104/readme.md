# Azure Administrator (AZ-104) - Lab Portfolio

This directory contains a collection of Infrastructure as Code (Bicep) deployments and technical labs designed to demonstrate proficiency in Azure administration, storage, and networking.

---

## 🚀 Project 1: Secure ZRS Storage Architecture
**Folder:** `01-Secure-ZRS-Storage`

### Business Scenario
The organization requires a storage solution for sensitive diagnostic data that must remain available even during a data center failure, while being completely isolated from the public internet.



### Technical Configuration
- **Redundancy:** Configured as **Zone-Redundant Storage (ZRS)**. This replicates data across three availability zones in the region.
- **Network Security:** Public Network Access is set to **Disabled**. 
- **Connectivity:** Designed for **Private Link** integration to ensure all traffic remains on the Microsoft backbone.

### AZ-104 Exam Concepts Covered
* **Storage Management:** Implementing Standard_ZRS for high availability.
* **Network Security:** Hardening storage accounts by disabling public endpoints.
* **Networking:** Preparing for Private Link/Private Endpoint integration.
* **IaC:** Automating secure deployments using Bicep.

---

## 🛠️ Deployment Instructions
1. Navigate to the specific project folder:
   ```bash
   cd AZ104/01-Secure-ZRS-Storage
