# 🌐 Project 02: Hybrid Networking & Secure Connectivity
[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![Networking](https://img.shields.io/badge/Networking-Hub--and--Spoke-blue.svg?style=for-the-badge)](https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/hub-spoke)

## 🎯 Project Objective
To architect a secure, scalable **Hub-and-Spoke** network topology. This project demonstrates the ability to connect multiple virtual networks via **VNet Peering** and provide secure administrative access using **Azure Bastion**, eliminating the need for public IP addresses on internal workloads.

---

## 🏗️ Architecture Overview
This lab simulates a corporate environment with a central "Hub" for shared services and a "Spoke" for specific application workloads.

* **Hub VNet:** Contains the **Azure Bastion** host for secure management.
* **Spoke VNet:** Contains the workload Virtual Machines (No Public IPs).
* **Connectivity:** Global VNet Peering with integrated DNS link.



---

## 🛠️ Technical Stack & Tools
| Category | Tools Used |
| :--- | :--- |
| **Connectivity** | Virtual Network Peering (Hub-to-Spoke) |
| **Secure Access** | Azure Bastion (PaaS) |
| **Traffic Control** | Network Security Groups (NSG) |
| **Name Resolution** | Azure Private DNS Zones |
| **Infrastructure** | Ubuntu Linux Nodes |

---

## 📸 Technical Evidence

### 1. Hub-and-Spoke VNet Design
I provisioned two distinct Virtual Networks with non-overlapping address spaces to allow for seamless peering.

![VNet Configuration](./images/01-vnet-setup.png)

<br>

### 2. VNet Peering & Transit
To allow the Hub and Spoke to communicate over the Azure backbone, I established a **Bi-directional VNet Peer**. I verified the peering status is `Connected` to ensure low-latency private routing.

![VNet Peering Proof](./images/02-vnet-peering.png)

<br>

### 3. Secure Management via Azure Bastion
To adhere to the **Zero Trust** security model, I deployed an Azure Bastion host.

