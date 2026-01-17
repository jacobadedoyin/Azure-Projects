# 🖥️ Project 02: Azure IaaS Compute & Networking

<a href="https://azure.microsoft.com/"><img src="https://img.shields.io/badge/🏗️_AZURE_IAAS-0072C6?style=for-the-badge&logo=microsoftazure&logoColor=white" height="50"></a>
<a href="https://learn.microsoft.com/en-us/azure/virtual-network/"><img src="https://img.shields.io/badge/🌐_VNET_SEGMENTATION-512BD4?style=for-the-badge&logo=azure-artifacts&logoColor=white" height="50"></a>
<a href="https://learn.microsoft.com/en-us/azure/network-security-group-overview"><img src="https://img.shields.io/badge/🛡️_NSG_HARDENING-D00000?style=for-the-badge&logo=azure-functions&logoColor=white" height="50"></a>
<a href="https://learn.microsoft.com/en-us/azure/reliability/availability-zones-overview"><img src="https://img.shields.io/badge/📈_HIGH_AVAILABILITY-00ca53?style=for-the-badge&logo=microsoftazure&logoColor=white" height="50"></a>
<a href="https://ubuntu.com/"><img src="https://img.shields.io/badge/🐧_UBUNTU_22.04-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" height="50"></a>

## 🎯 Project Objective
To demonstrate the deployment of foundational Infrastructure as a Service (IaaS) components, including Virtual Machines and secure Virtual Networking, with a focus on **Network Security Hardening** and **High Availability** to ensure a resilient, production-ready cloud environment that meets enterprise compliance standards and production requirments.

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
 I engineered a **segmented network architectur**e to align with enterprise-grade security standards. By implementing logical separation between workloads, I ensured that the infrastructure is resilient against lateral movement, effectively isolating services and narrowing the scope of potential security incidents


### 1. VNet & Subnet Configuration
I configured specific address spaces and subnets to ensure logical segmentation of traffic within the environment.

![VNet Configuration](images/vnet-subnets-config.png)
> **Figure 1:** Configuration of the Virtual Network address space and subnet segmentation in the Azure Portal.

**Architectural Rationale:**
* **Threat Containment:** By partitioning the environment into functional subnets (e.g., Management vs. Application tiers), I ensured that a compromise in one zone cannot easily transition to another.
* **Address Space Management:** Utilized a `10.0.0.0/16` CIDR block to provide a scalable IP pool, ensuring the infrastructure can grow without the need for complex and costly network re-addressing later.
* **Regional Strategy:** Choosing **North Europe** ensures GDPR compliance and provides the low-latency performance required for regional business operations.

| Subnet Name | Address Range | Purpose |
| :--- | :--- | :--- |
| **Default** | `10.0.0.0/24` | Primary workload and Application tier. |
| **AzureGatewaySubnet**| `10.0.1.0/24` | Reserved for VPN/ExpressRoute connectivity. |


---

## 💻 Phase 2: Compute Deployment (IaaS)
I provisioned a high-performance Linux environment optimized for reliability. By using **Availability Zones**, I ensured the workload remains resilient against local data center failures.



### 2. VM Essentials & High Availability
* **Size:** Standard D2s v3 (2 vCPUs, 8 GiB memory)
* **High Availability:** Deployed in **Availability Zone 3** for fault tolerance.
* **Metadata:** Applied project-specific tags for cost tracking.

<br>

![VM Essentials](images/vm-deployment-essentials.png)
> **Figure 2:** Virtual Machine overview showing the successful deployment in Availability Zone 3 (North Europe).

---

## 🛡️ Phase 3: Security Hardening (NSG)
A critical part of this lab was identifying and remediating common network security vulnerabilities using Network Security Groups (NSGs).



### 3. Identifying the Security Risk
The default Network Security Group (NSG) configuration flagged a risk: allowing **SSH (Port 22)** from "Any" source. This exposes the VM to global brute-force attacks.

<br>

![NSG Security Error](images/nsg-security-rules-error.png)
> **Figure 3:** The initial security assessment highlighting the 'High Risk' warning due to open SSH ports.

### 4. Implementing the Resolution (IP Filtering)
I hardened the network by implementing a **Source IP Filter**. I modified the inbound rules to strictly permit traffic *only* from my specific administrative IP address. All other traffic is dropped by the `DenyAllInbound` rule, adhering to the **Principle of Least Privilege**.

<br>

![Hardened NSG Rules](images/nsg-security-rules.png)
> **Figure 4:** The hardened NSG configuration, restricting SSH access strictly to the administrator's IP address.

---

## 🧠 Key Cloud Concepts Covered
* **IaaS (Infrastructure as a Service):** Managing the OS and network layer while Azure handles physical hardware.
* **Fault Tolerance:** Leveraging **Availability Zones** to ensure uptime during regional disruptions.
* **Stateful Firewalling:** Using **NSGs** to control flow at the network interface level.
* **Attack Surface Reduction:** Minimizing external exposure by limiting management ports to trusted sources.

---

## 🧹 Maintenance & Cleanup
To adhere to cloud cost management principles and prevent billing for idle compute resources, the environment was decommissioned.

1. **Resource Deletion:** The entire Resource Group was deleted, removing the VM, Disk, NIC, and VNet simultaneously.
2. **Verification:** Confirmed the stop of billing meters via the Cost Management blade.

---
*Created by Jacob Adedoyin-Griffiths | Azure 900 Portfolio*
