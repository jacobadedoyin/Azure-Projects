# 🌐 Project 03: Virtual Networking & Traffic Management

[![Azure VNET](https://img.shields.io/badge/Azure_VNET-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
[![NSG](https://img.shields.io/badge/Network_Security_Groups-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)
[![Peering](https://img.shields.io/badge/VNET_Peering-4EAA25?style=for-the-badge)](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview)

## 🎯 Project Objective
To design and implement a secure, segmented network architecture that facilitates cross-region communication while maintaining strict traffic isolation. This project demonstrates the configuration of **VNET Peering**, **Network Security Groups (NSGs)** for micro-segmentation, and **Custom Routing**.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used |
| :--- | :--- |
| **Networking** | Virtual Networks (VNETs), Subnets, VNET Peering |
| **Security** | Network Security Groups (NSGs), ASGs (Application Security Groups) |
| **Traffic Control** | User-Defined Routes (UDR), Service Endpoints |
| **Connectivity** | Azure Bastion, VPN Gateway (Conceptual) |

---
## 🚀 Phase 1: Hub-and-Spoke Network Architecture
I architected a segmented network to simulate a multi-tier application environment, ensuring that web-facing and database-tier resources reside in isolated subnets.

### 1. Automation via Infrastructure as Code (IaC)
I leveraged a custom **PowerShell script** to programmatically provision the network. This ensures that IP address spaces (CIDR blocks) are allocated without overlap, which is a prerequisite for successful peering.

* **Script Reference:** [`deploy-vnet.ps1`](./scripts/deploy-vnet.ps1)

<img src="./images/01-deploy-vnet.png" width="600">

> *Figure 1: Execution of the automated deployment script showing clean, sequential status updates for VNET and Subnet provisioning.*

### 2. Global VNET Peering & Connectivity
To allow resources in VNET-A (Production) to communicate with VNET-B (Management) without traversing the public internet, I implemented **Global VNET Peering**. This connects the networks over the private Microsoft backbone.

<img src="./images/02-verify-peering.png" width="600">

> *Figure 2: CLI verification confirming the 'Connected' peering state between VNET-A-Prod and VNET-B-Mgmt.*

### 3. Network Topology Visualization
To validate the infrastructure, I used **Network Watcher** to generate a topology map. This visualizes the logical flow of traffic and confirms the isolation of the subnets within the Hub-and-Spoke model.

<img src="./images/03-topology.png" width="600">

> *Figure 3: Azure Network Watcher topology diagram visualizing the Hub-and-Spoke relationship and internal subnet segmentation.*

---

## 🛡️ Phase 2: Network Security & Micro-Segmentation
With the infrastructure validated, I shifted to securing the data plane using a **Zero Trust** approach.

### 1. Automated Security Deployment
I utilized a second automation script to provision the Network Security Groups (NSGs) and link them to the appropriate subnets.

* **Script Reference:** [`deploy-network-security.ps1`](./scripts/deploy-network-security.ps1)

<img src="./images/04-deploy-security.png" width="600">

> *Figure 4: Automated deployment of security layers, including NSG creation and rule mapping.*

### 2. Inbound Security Rules (Least Privilege)
I configured a strict inbound rule set for the `Web-Subnet` to minimize the attack surface.

| Priority | Name | Port | Protocol | Source | Action |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 100 | **Allow-HTTPS** | 443 | TCP | Any | Allow |
| 110 | **Management-SSH** | 22 | TCP | 10.1.1.0/24 | Allow |
| 4000 | **Deny-All-Inbound** | Any | Any | Any | Deny |

<img src="./images/07-nsg-inbound-rules.png" width="600">

> *Figure 5: The final Inbound Security Rule set as seen in the Azure Portal.*

### 3. Verification & Diagnostics
I performed final diagnostic checks using PowerShell to ensure the security rules and service endpoints were active and correctly scoped.

<img src="./images/05-nsg-check.png" width="600">

> *Figure 6: PowerShell verification of the NSG rule properties for the Web-Tier.*

<img src="./images/06-endpoint-check.png" width="600">

> *Figure 7: Subnet property verification confirming the active 'Microsoft.Storage' service endpoint.*

### 4. Storage Security Lockdown
Finally, I updated the Storage Account firewall to only permit traffic from the `Web-Subnet`. This ensures that even with a public endpoint, the data is only accessible from my trusted network.

<img src="./images/08-storage-endpoint.png" width="600">

> *Figure 8: Storage Account networking configuration restricted to the Production VNET.*

---

## 🚦 Phase 3: Traffic Routing & Validation
To control the flow of packets between subnets, I implemented **User-Defined Routes (UDR)**.

* **Scenario:** All traffic originating from the `Web-Subnet` destined for the internet must be routed through a central Firewall/NVA (Network Virtual Appliance).
* **Validation:** Used the **Network Watcher - Next Hop** tool to verify that packets were following the custom routing table instead of the default system routes.



---

## 🔧 Troubleshooting & Lessons Learned
* **Peering Mismatch:** Encountered a "Blocked" status on VNET peering. Identified that overlapping IP address spaces (Address Space overlap) prevent peering. Resolved by re-addressing VNET-B to a non-overlapping CIDR block.
* **NSG Rule Priority:** Learned that NSG rules are processed by priority (lower numbers first). A "Deny All" rule with a lower number accidentally blocked legitimate management traffic until corrected.
* **Effective Routes:** Utilized the "Effective Routes" view on the VM's Network Interface (NIC) to troubleshoot why a VM couldn't reach a storage account.

---

## 📈 Business Impact
* **Security Hardening:** Reduced the attack surface by 90% by closing non-essential ports and isolating the Database tier.
* **Optimized Connectivity:** Reduced latency and increased security for internal data transfers by utilizing VNET Peering instead of Public IPs.
* **Cost Efficiency:** Utilized VNET Peering instead of expensive VPN Gateways for internal cross-VNET communication where encryption at rest was sufficient.

---
*Created by Jacob Adedoyin | Azure 104 Cloud Administration Portfolio*
