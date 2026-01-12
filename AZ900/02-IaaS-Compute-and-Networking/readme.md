# Project 02: IaaS Compute and Networking

## 🎯 Objective
To demonstrate the deployment of foundational Infrastructure as a Service (IaaS) components, including Virtual Machines and secure Virtual Networking, with a focus on **Security Hardening**.

---

## 📸 Technical Evidence

### 1. Virtual Network (VNet) Configuration
I designed a custom Virtual Network (`vm-lab-jacob-vnet`) in **North Europe**. This provides the private network boundary required for all cloud resources.
![VNet Configuration](images/vnet-subnets-config.png)

### 2. Virtual Machine Deployment (IaaS)
I deployed a **Linux (Ubuntu 22.04)** Virtual Machine. 
* **Size:** Standard D2s v3 (2 vCPUs, 8 GiB memory)
* **High Availability:** Deployed in **Availability Zone 3** for fault tolerance.
* **Governance:** Applied tags to ensure the resource is identified within the project's cost center.
![VM Essentials](images/vm-deployment-essentials.png)

### 3. Security Troubleshooting: Resolving the "Open Port" Risk
During the initial setup, the Network Security Group (NSG) flagged a security risk. By default, allowing SSH on Port 22 from "Any" source which exposes the VM to brute-force attacks from the public internet.

**The Security Risk (Open to Any):**
![NSG Security Error](images/nsg-security-rules-error.png)

**The Resolution (Hardened Security):**
I resolved this by implementing a **Source IP Filter**. I modified the NSG rules to only permit traffic from my specific administrative IP address (blocked out). All other traffic is dropped by the default `DenyAllInbound` rule.
![Hardened NSG Rules](images/nsg-security-rules.png)

---

## 💡 Key AZ-900 Concepts Covered
- **IaaS (Infrastructure as a Service):** Managing the operating system and network settings while Azure manages the physical hardware.
- **Availability Zones:** Using North Europe Zone 3 to protect against data center outages.
- **Network Security Groups (NSG):** Operating as a stateful firewall to filter traffic.
- **Principle of Least Privilege:** Restricting management access (SSH) to a single trusted IP rather than the entire internet.
