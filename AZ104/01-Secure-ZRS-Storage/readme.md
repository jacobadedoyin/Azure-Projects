## Deployment Evidence & Technical Analysis

---

### 1. High Availability & Regional Resiliency

<img src="https://raw.githubusercontent.com/jacobadedoyin/Azure-Projects/main/AZ104/01-Secure-ZRS-Storage/Storage-Overview.png" width="700" alt="Storage Overview">

**Technical Analysis:**
* **Region (UK South):** Deployed to the London region to ensure data residency compliance and low latency for localized workloads.
* **Redundancy (ZRS):** Configured **Zone-Redundant Storage**. Unlike Locally-Redundant Storage (LRS), ZRS synchronously replicates data across three distinct Azure availability zones within the region, ensuring the application survives a data center-level failure.

---

### 2. Zero-Trust Security Configuration

<img src="https://raw.githubusercontent.com/jacobadedoyin/Azure-Projects/main/AZ104/01-Secure-ZRS-Storage/Storage-Audit.png" width="700" alt="Storage Audit">

**Technical Analysis:**
* **Public Access (Disabled):** Following Zero-Trust maturity models, public internet access is strictly disabled. This significantly reduces the attack surface by preventing anonymous or external connection attempts.
* **Network Isolation:** The audit confirms traffic is restricted to trusted services. The architectural roadmap includes transitioning to **Private Endpoints (Private Link)** to ensure all data remains on the Microsoft backbone network.
* **Compliance:** Configuration verified via Azure CLI and Bicep deployment logs to ensure "Configuration as Code" integrity.
