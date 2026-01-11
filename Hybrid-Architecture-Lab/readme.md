# Hybrid Architecture Lab 🌉

## 🎯 Objective
This lab focuses on the **"Bridge"** between legacy on-premises infrastructure and the modern cloud. In this environment, I demonstrate how to maintain a single source of truth for identity and secure connectivity across a distributed network.

---

## 🏗️ Featured Implementation: Hybrid Identity (Entra Connect)
The core of this lab is the synchronization of a local Active Directory Domain Services (AD DS) environment with **Microsoft Entra ID**.

### 🛠️ Technical Workflow
1.  **On-Premises Simulation:** Provisioned a Windows Server environment acting as a local Domain Controller.
2.  **Directory Synchronization:** Configured **Microsoft Entra Connect** to bridge the identity gap.
3.  **Security Validation:** Implemented Password Hash Synchronization (PHS) to ensure a seamless yet secure sign-on experience for remote users.



---

## 💡 Why this matters for the Business
* **Operational Efficiency:** One set of credentials for users, whether they are in the office or working remotely.
* **Security Guardrails:** Centralized identity management allows for faster offboarding and tighter access control (MFA/Conditional Access).
* **Scalability:** Provides a foundation for moving on-premises workloads to Azure without re-creating user profiles.

---
*Status: 🚧 Lab currently in final validation phase (AZ-104 Milestone).*
