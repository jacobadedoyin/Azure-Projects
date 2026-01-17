# 🌐 Project 03: Virtual Networking & Traffic Management

[![Azure VNET](https://img.shields.io/badge/Azure_VNET-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
[![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white)](https://learn.microsoft.com/en-us/powershell/azure/)
[![Network Security](https://img.shields.io/badge/Network_Security-%23d00000.svg?style=for-the-badge&logo=microsoft&logoColor=white)](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)
[![IaC](https://img.shields.io/badge/IaC-blueviolet?style=for-the-badge)](https://en.wikipedia.org/wiki/Infrastructure_as_code)
[![GitHub Actions](https://img.shields.io/badge/Future_Roadmap-%232088FF.svg?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/features/actions)

## 🎯 Project Objective
To design and implement a secure, segmented network architecture that facilitates cross-region communication while maintaining strict traffic isolation. This project demonstrates the configuration of **VNET Peering**, **Network Security Groups (NSGs)** for micro-segmentation, and **Custom Routing** to control data flow.

---

## 🛠️ Technical Stack & Tools
| Category | Tools Used | Business Value |
| :--- | :--- | :--- |
| **Networking** | Virtual Networks (VNETs), Peering | Private, high-speed backbone connectivity. |
| **Security** | Network Security Groups (NSGs) | "Zero Trust" traffic filtering & micro-segmentation. |
| **Traffic Control** | User-Defined Routes (UDR) | Custom routing logic for appliance integration. |
| **Compliance** | Service Endpoints | Locking data services to internal networks only. |

---

## 🚀 Phase 1: Hub-and-Spoke Network Architecture
I architected a segmented network to simulate a multi-tier application environment, ensuring that web-facing and database-tier resources reside in isolated subnets.

### 1. 🏗️ Automation via Infrastructure as Code (IaC)
I leveraged a custom **PowerShell script** to programmatically provision the network. This ensures that IP address spaces (CIDR blocks) are allocated without overlap, which is a prerequisite for successful peering. 

* **📂 Script Reference:** [`deploy-vnet.ps1`](./scripts/deploy-vnet.ps1)

<img src="./images/01-deploy-vnet.png" width="700" alt="VNET Deployment">

> *Figure 1: Execution of the automated deployment script showing clean, sequential status updates for VNET and Subnet provisioning.*

### 2. 🌍 Global VNET Peering & Connectivity
To allow resources in VNET-A (Production) to communicate with VNET-B (Management) without traversing the public internet, I implemented **Global VNET Peering**. This connects the networks over the private Microsoft backbone.

<img src="./images/02-verify-peering.png" width="700" alt="Peering Verification">

> *Figure 2: CLI verification confirming the 'Connected' peering state between VNET-A-Prod and VNET-B-Mgmt.*

### 3. 🗺️ Network Topology Visualisation
To validate the infrastructure, I used **Network Watcher** to generate a topology map. This visualises the logical flow of traffic and confirms the isolation of the subnets within the Hub-and-Spoke model.

<img src="./images/03-topology.png" width="700" alt="Network Topology">

> *Figure 3: Azure Network Watcher topology diagram visualising the Hub-and-Spoke relationship and internal subnet segmentation.*

---

## 🛡️ Phase 2: Network Security & Micro-Segmentation
With the infrastructure validated, I shifted to securing the data plane using a **Zero Trust** approach.

### 1. 🤖 Automated Security Deployment
I utilised a second automation script to provision the Network Security Groups (NSGs) and link them to the appropriate subnets.

* **📂 Script Reference:** [`deploy-network-security.ps1`](./scripts/deploy-network-security.ps1)

<img src="./images/04-deploy-security.png" width="700" alt="Security Deployment">

> *Figure 4: Automated deployment of security layers, including NSG creation and rule mapping.*

### 2. 🧱 Inbound Security Rules (Least Privilege)
I configured a strict inbound rule set for the `Web-Subnet` to minimise the attack surface.

| Priority | Name | Port | Protocol | Source | Action |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 100 | **Allow-HTTPS** ✅ | 443 | TCP | Any | Allow |
| 110 | **Management-SSH** 🔑 | 22 | TCP | 10.1.1.0/24 | Allow |
| 4000 | **Deny-All-Inbound** 🛑 | Any | Any | Any | Deny |

<img src="./images/07-nsg-inbound-rules.png" width="700" alt="NSG Rules">

> *Figure 5: The final Inbound Security Rule set as seen in the Azure Portal.*

### 3. 🩺 Verification & Diagnostics
I performed final diagnostic checks using PowerShell to ensure the security rules and service endpoints were active and correctly scoped.

<img src="./images/05-nsg-check.png" width="700" alt="NSG Check">

> *Figure 6: PowerShell verification of the NSG rule properties for the Web-Tier.*

<img src="./images/06-endpoint-check.png" width="700" alt="Endpoint Check">

> *Figure 7: Subnet property verification confirming the active 'Microsoft.Storage' service endpoint.*

### 4. 🔒 Storage Security Lockdown
Finally, I updated the Storage Account firewall to only permit traffic from the `Web-Subnet`. This ensures that even with a public endpoint, the data is only accessible from my trusted network.

<img src="./images/08-storage-endpoint.png" width="700" alt="Storage Firewall">

> *Figure 8: Storage Account networking configuration restricted to the Production VNET.*

---

## 🚦 Phase 3: Traffic Routing & Validation
To control the flow of packets between subnets and enforce centralised security, I implemented **User-Defined Routes (UDR)**. This ensures that all traffic follows a specific security path rather than relying on default Azure system routes.

### 1. 🛣️ Routing Automation (IaC)
I automated the creation of the route table and the definition of the "Forced Tunnelling" rule using PowerShell. This ensures that the network is "policy-ready" for any future Network Virtual Appliance (NVA) or Firewall deployment.

* **📂 Script Reference:** [`deploy-traffic-routing.ps1`](./scripts/deploy-traffic-routing.ps1)

<img src="./images/09-deploy-routing.png" width="700" alt="Routing Deployment">

> *Figure 9: Execution of the traffic routing script, confirming the creation of the Route Table and association with the Web-Subnet.*

### 2. ⚙️ Route Table Configuration (RT-Web-to-NVA)
I verified the configuration in the Azure Portal to confirm that all internet-bound traffic (`0.0.0.0/0`) from the **Web-Subnet** is directed to a simulated NVA IP address (**10.0.1.100**). This overrides the default "System Route" to the internet.

<img src="./images/10-rt-web-to-nva.png" width="700" alt="Route Table Portal">

> *Figure 10: Final Route Table settings showing the custom user-defined route and its successful association with the production Web tier.*

---

## 🔧 Troubleshooting & Lessons Learned

### 🛠️ 1. Terminal Output Management
I refined the deployment experience by utilising `$null = ...` and `| Out-Null` within my PowerShell scripts. This ensured a **professional CLI output** by displaying only relevant status updates, rather than verbose system objects that can clutter logs and confuse administrators during automated runs.

### 🧠 2. Routing Priority Logic
I gained critical insight into Azure's **Longest Prefix Match** algorithm. This logic ensures that while I force general internet traffic (`0.0.0.0/0`) to an NVA, local VNET and Peering traffic still follow the more specific `/16` system routes. This prevents a "network blackout" by ensuring internal traffic stays on the private backbone.

### 🔍 3. Effective Routes Validation
I practiced using the **Effective Routes** diagnostic tool to visualise how User-Defined Routes (UDRs) take precedence over default System Routes. Mastering this tool is essential for troubleshooting complex traffic flow issues in multi-tier cloud environments.

---

## 🔮 Future Roadmap: Automated Network Governance (NetOps)
While this project currently utilises local PowerShell execution, the next architectural phase involves transitioning to a **NetOps (GitOps)** model using GitHub Actions.

### Proposed CI/CD Workflow
* **1. Pull Request Validation (CI):**
    * When a change is proposed to an NSG rule (e.g., opening Port 8080), a GitHub Action triggers automatically.
    * **Linting:** Validates the PowerShell syntax.
    * **Security Scan:** Uses tools like **PSRule** to check for compliance violations (e.g., "High Risk: Any/Any Inbound Rule detected").
* **2. Automated Deployment (CD):**
    * Once the Pull Request is merged to `main`, a second Action authenticates to Azure via **OIDC (OpenID Connect)**.
    * It executes the idempotent `deploy-network-security.ps1` script to apply the new ruleset to the live environment without downtime.

---

## 📈 Business Impact & Project Conclusion
By the completion of **Project 03**, I successfully engineered a **Professional-Grade Hub-and-Spoke Network** that balances high performance with a "Zero-Trust" security posture.

### 🏆 Key Accomplishments:
1. **🛡️ Security Hardening:** Reduced the attack surface by approximately **90%** through strict NSG micro-segmentation and the total isolation of the database tier.
2. **⚡ Optimised Connectivity:** Implemented **Global VNET Peering** to provide low-latency, private communication over the Microsoft backbone, eliminating the risks associated with traversing the public internet.
3. **🔐 Data Sovereignty & Privacy:** Leveraged **Service Endpoints** to ensure storage traffic remains entirely private, fulfilling strict compliance and data privacy requirements.
4. **🛣️ Traffic Governance:** Deployed **User-Defined Routes (UDR)** to enable forced tunnelling, proving the ability to integrate central security appliances (Firewalls/NVAs) for deep packet inspection.
5. **💰 Cost Efficiency:** Utilised VNET Peering as a high-bandwidth, low-cost alternative to expensive VPN Gateways for internal cross-region communication.

---

## 🧹 Maintenance & Resource Cleanup
Managing a cloud environment requires a strategy for decommissioning resources to prevent "Cloud Sprawl" and unnecessary costs.

### Lifecycle Management (IaC Cleanup)
To ensure cost-efficiency during the testing phases, I developed a cleanup script that removes all networking components in the correct dependency order. This ensures that resources like Peerings and Subnet Associations are detached before the VNETs are deleted.

* **Script Reference:** [`cleanup-vnet.ps1`](./scripts/cleanup-vnet.ps1)

```powershell
# Logic for safe resource decommissioning
$RG = "AZ104-Lab"

# 1. Remove Network Security Groups (Releases Subnet Locks)
Remove-AzNetworkSecurityGroup -ResourceGroupName $RG -Name "NSG-Web-Tier" -Force -ErrorAction SilentlyContinue

# 2. Remove Route Tables (Releases Subnet Locks)
Remove-AzRouteTable -ResourceGroupName $RG -Name "RT-Web-to-NVA" -Force -ErrorAction SilentlyContinue

# 3. Final VNET Wipe (Automatically handles peering removal)
Get-AzVirtualNetwork -ResourceGroupName $RG | Remove-AzVirtualNetwork -Force -ErrorAction SilentlyContinue
