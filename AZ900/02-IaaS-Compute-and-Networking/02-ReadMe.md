# AZ900 Project 02: 🖥️ Azure IaaS Compute & Networking
[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![Networking](https://img.shields.io/badge/Networking-VNet-blue.svg?style=for-the-badge)](https://learn.microsoft.com/en-us/azure/virtual-network/)
[![Security](https://img.shields.io/badge/Security-Hardening-red.svg?style=for-the-badge)](https://learn.microsoft.com/en-us/azure/network-security-group-overview)

## 🎯 Project Objective
To demonstrate the deployment of foundational Infrastructure as a Service (IaaS) components, including Virtual Machines and secure Virtual Networking, with a focus on **Network Security Hardening** and **High Availability**.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used |
| :--- | :--- |
| **Compute** | Azure Virtual Machines (Ubuntu 22.04 LTS) |
| **Networking** | Virtual Networks (VNet), Subnets |
| **Security** | Network Security Groups (NSG), IP Filtering |
| **Availability** | Availability Zones (Zonal Deployment) |
| **Region** | North Europe |

---

## 🌐 Phase 1: Virtual Networking Infrastructure
The backbone of the deployment is a custom Virtual Network (`vm-lab-jacob-vnet`) designed in **North Europe**. This provides the isolated private network boundary required for secure cloud communication.



### 1. VNet & Subnet Configuration
I configured specific address spaces and subnets to ensure logical segmentation of traffic within the environment.

![VNet Configuration](images/vnet-subnets-config.png)

---

## 💻 Phase 2: Compute Deployment (IaaS)
I provisioned a high-performance Linux environment optimized for reliability. By using **Availability Zones**, I ensured the workload remains resilient against local data center failures.

### 2. VM Essentials & High Availability
* **Size:** Standard D2s v3 (2 vCPUs, 8 GiB memory)
* **High Availability:** Deployed in **Availability Zone 3** for fault tolerance.
* **Metadata:** Applied project-specific tags for cost tracking.

![VM Essentials](images/vm-deployment-essentials.png)

---

## 🛡️ Phase 3: Security Hardening (NSG)
A critical part of this lab was identifying and remediating common network security vulnerabilities. 

### 3. Identifying the Security Risk
The default Network Security Group (NSG) configuration flagged a risk: allowing **SSH (Port 22)** from "Any" source. This exposes the VM to global brute-force attacks.

![NSG Security Error](images/nsg-security-rules-error.png)

<br>

### 4. Implementing the Resolution (IP Filtering)
I hardened the network by implementing a **Source IP Filter**. I modified the inbound rules to strictly permit traffic *only* from my specific administrative IP address. All other traffic is dropped by the `DenyAllInbound` rule, adhering to the **Principle of Least Privilege**.



![Hardened NSG Rules](images/nsg-security-rules.png)

---

## 🧠 Key Cloud Concepts Covered
* **IaaS (Infrastructure as a Service):** Managing the OS and network layer while Azure handles physical hardware.
* **Fault Tolerance:** Leveraging **Availability Zones** to ensure uptime during regional disruptions.
* **Stateful Firewalling:** Using **NSGs** to control flow at the network interface level.
* **Attack Surface Reduction:** Minimizing external exposure by limiting management ports to trusted sources.

---
*Created by Jacob Adedoyin-Griffiths | Azure 900 Portfolio*
