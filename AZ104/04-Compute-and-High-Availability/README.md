# ⚖️ Project 04: High Availability Compute & Autoscaling

[![Azure Compute](https://img.shields.io/badge/Azure_Compute-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/en-us/products/virtual-machines/)
[![Load Balancer](https://img.shields.io/badge/Load_Balancer-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/en-us/products/load-balancer/)
[![VMSS](https://img.shields.io/badge/VM_Scale_Sets-4EAA25?style=for-the-badge)](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/)
[![Monitor](https://img.shields.io/badge/Azure_Monitor-512BD4?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/en-us/products/monitor/)
[![IaC](https://img.shields.io/badge/IaC-Infrastructure%20As%20Code-blueviolet?style=for-the-badge)](https://en.wikipedia.org/wiki/Infrastructure_as_code)

## 🎯 Project Objective
To architect a resilient, self-healing web infrastructure that can handle sudden traffic spikes without downtime. This project simulates a real-world e-commerce scenario, utilizing **Virtual Machine Scale Sets (VMSS)** for elasticity, **Layer-4 Load Balancing** for traffic distribution, and **Azure Monitor** for operational observability.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used |
| :--- | :--- |
| **Compute** | Virtual Machine Scale Sets (VMSS), Ubuntu Linux |
| **Networking** | Azure Standard Load Balancer (Layer 4) |
| **Automation** | Cloud-Init (YAML), Custom Script Extensions |
| **Observability** | Azure Monitor, Action Groups, Metric Alerts |
| **Disaster Recovery** | Recovery Services Vault (Backup) |

---

## 🚀 Phase 1: High Availability Architecture
I moved beyond single Virtual Machines by implementing a **Scale Set** architecture. This ensures that the application is not dependent on a single server (Single Point of Failure).

### 1. Automated Configuration (Cloud-Init)
Instead of manually logging into servers, I used a **Cloud-Init** configuration to bootstrap the web server application immediately as the VM launches.

* **Boot Logic:** Installs Nginx, creates a custom `index.html` showing the hostname, and opens Port 80.

<img src="./images/01-cloud-init-config.png" width="700" alt="Cloud Init Configuration">

> *Figure 1: The configuration profile used to automatically provision web servers.*

### 2. Load Balancer Implementation
To distribute ingress traffic, I deployed a **Standard Azure Load Balancer**.
* **Health Probes:** Configured a TCP probe on Port 80 to check instance health every 5 seconds.
* **Backend Pool:** The Scale Set instances were automatically registered to the backend pool for traffic distribution.

<img src="./images/02-load-balancer-map.png" width="700" alt="Load Balancer Map">

> *Figure 2: Visualizing the traffic flow from the Public IP → Load Balancer → Backend Instances.*

---

## 📈 Phase 2: Autoscaling & Stress Testing
This phase demonstrates the "Elasticity" of the cloud. I configured autoscale rules to dynamically add or remove servers based on demand, optimizing costs.

### 1. Defining Autoscale Rules
I implemented a CPU-based scaling policy:
* **Scale Out (Add +1 VM):** Triggered when Average CPU > 75% for 5 minutes.
* **Scale In (Remove -1 VM):** Triggered when Average CPU < 25% for 5 minutes.

<img src="./images/03-scale-settings.png" width="700" alt="Autoscale Settings">

> *Figure 3: The horizontal scaling profile ensuring cost-efficiency during low traffic.*

### 2. Simulating High Load
To validate the logic, I generated synthetic CPU load on the instances using the `stress-ng` tool.

```bash
# Command used to spike CPU to 100% on 4 cores
sudo apt-get install stress-ng -y
stress-ng --cpu 4 --timeout 300
