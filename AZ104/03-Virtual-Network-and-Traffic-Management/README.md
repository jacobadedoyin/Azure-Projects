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

### 1. VNET Provisioning & Subnet Segmentation
I deployed two primary VNETs to test cross-network connectivity:
* **VNET-A (Production):** Divided into `Web-Subnet` and `DB-Subnet`.
* **VNET-B (Management):** A separate network to simulate a management or shared-services hub.



### 2. Global VNET Peering
To allow resources in VNET-A to communicate with VNET-B without traversing the public internet, I implemented **Global VNET Peering**. 
* **Key Configuration:** Enabled "Allow forwarded traffic" and "Allow gateway transit" to support future hybrid connectivity.

---

## 🛡️ Phase 2: Network Security & Micro-Segmentation
To enforce a **Zero Trust** security model, I implemented Network Security Groups (NSGs) to act as a distributed firewall at the subnet level.

### 1. Inbound Security Rules
I configured a "Least Privilege" access model:
* **Allow-HTTPS:** Opened Port 443 for public web traffic.
* **Deny-All-Inbound:** A high-priority rule to block all unsolicited traffic from the internet.
* **Management-SSH:** Restricted SSH/RDP access to a specific "Management Subnet" IP range only.



### 2. Service Endpoints
I enabled **Service Endpoints** for `Microsoft.Storage`. This ensures that traffic from the Virtual Machines to Azure Storage remains entirely on the Microsoft backbone network, bypassing the public internet for enhanced security and lower latency.

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
