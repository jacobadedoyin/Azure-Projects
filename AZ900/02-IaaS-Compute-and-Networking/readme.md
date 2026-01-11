# Project 02: IaaS Compute and Networking

## 🎯 Objective
To demonstrate the deployment of foundational Infrastructure as a Service (IaaS) components, including Virtual Machines and secure Virtual Networking.

## 📸 Technical Evidence

### 1. Virtual Network (VNet) Configuration
I designed a Virtual Network to provide a private environment for Azure resources. This included defining the address space and subnets required for secure communication.
![VNet Configuration](vnet-setup.png)

### 2. Virtual Machine Deployment
I deployed a Virtual Machine (Compute) within the VNet. This involved selecting the appropriate size and OS image to meet specific workload requirements.
![VM Overview](vm-deployment.png)

### 3. Network Security Group (NSG) Rules
I configured NSG inbound rules to permit specific traffic (e.g., RDP/SSH) while blocking all other unauthorized access, demonstrating the "Principle of Least Privilege" in networking.
![NSG Rules](nsg-security-rules.png)

---

## 💡 Key AZ-900 Concepts Covered
- **IaaS (Infrastructure as a Service):** Managing servers, storage, and networking as virtualized services.
- **Virtual Networks (VNet):** Providing isolation and segmentation for cloud resources.
- **Network Security Groups (NSG):** Filtering network traffic to and from Azure resources.
- **Public vs. Private IPs:** Understanding how resources communicate with the internet and each other.
