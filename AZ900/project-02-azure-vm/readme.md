# Project 02: Deploying an Azure Virtual Machine (IaaS)

## Overview
This project demonstrates the deployment of an Azure Virtual Machine (VM) and the supporting infrastructure required for it to function. It highlights the **Infrastructure as a Service (IaaS)** model, where the user manages the OS and applications while Azure manages the underlying hardware.

## Business Scenario
A development team needs a sandbox environment to test a web application. The solution requires a Virtual Machine that can be accessed via RDP/SSH, secured by a firewall (NSG), and hosted within a dedicated Virtual Network.


## AZ-900 Concepts Demonstrated

* **IaaS (Infrastructure as a Service):** Managing the virtual machine lifecycle from deployment to maintenance.
* **Shared Responsibility Model:** Azure manages the physical host and hypervisor; I manage the VM's OS, security patches, and network rules.
* **Network Security:** Implementing the principle of least privilege by using **Network Security Groups** to filter traffic
