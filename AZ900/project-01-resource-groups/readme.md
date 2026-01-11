# Project 01: Resource Group & Storage Lifecycle

## Overview
This project demonstrates the core Azure fundamental concept of **Resource Groups**. It explores how to organize, secure, and manage the lifecycle of multiple Azure resources as a single logical unit.

## Business Scenario
The marketing department requires a sandbox environment to store assets. The solution must ensure that all related resources (Storage, Networking, etc.) can be tracked for billing and deleted simultaneously when the project concludes to prevent "cloud sprawl" and unnecessary costs.

---

## Technical Implementation

### 1. Resource Group Provisioning
* **Name:** `rg-marketing-sandbox`
* **Region:** `UK South` (London)
* **Purpose:** Acts as a management boundary for the storage assets.

### 2. Resource Deployment
Within this group, a Standard Storage Account was provisioned to test resource inheritance and management.

<img src="https://raw.githubusercontent.com/jacobadedoyin/Azure-Projects/main/AZ900/project-01-resource-groups/storage-account-overview.png" width="700" alt="Storage Account Overview">



---

## AZ-900 Concepts Demonstrated

* **Resource Groups:** Using containers to manage multiple resources.
* **Region Selection:** Understanding the importance of data residency and latency by deploying to `UK South`.
* **Resource Tags:** (Optional) Applying metadata for cost center tracking.
* **Lifecycle Management:** Demonstrating how deleting a Resource Group automatically cleans up all nested resources, ensuring cost efficiency.

## Key Learnings
1. **Management Boundaries:** Resource groups do not restrict technical communication between resources, but they are essential for administrative and billing boundaries.
2. **Location Independence:** Resources within a group can technically reside in different regions than the group itself, though keeping them aligned is best practice for metadata residency.
