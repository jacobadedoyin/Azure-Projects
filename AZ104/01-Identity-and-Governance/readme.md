# Project 1: Identity and Governance (AZ-104)

## Overview
This project demonstrates the foundational setup of an Azure environment. It focuses on automating user management and enforcing organizational compliance through **Azure Policy** and **RBAC (Role-Based Access Control)**.

## Project Components

### 1. Identity Automation (`/scripts`)
* **File:** `create-identities.ps1`
* **Description:** A PowerShell script that automates the creation of Microsoft Entra ID (Azure AD) users and security groups. 
* **Skills Demonstrated:** Azure PowerShell, Bulk User Management, Group Nesting.

### 2. Governance & Compliance (`/policies`)
* **File:** `allowed-vms.json`
* **Description:** A custom Azure Policy definition that restricts the deployment of Virtual Machines to specific SKUs (Standard_B1s, Standard_B2s). 
* **Goal:** Cost management and preventing "shadow IT" from deploying expensive resources.

## Implementation Steps
1. **Bulk Upload:** Ran the PowerShell script to create the `IT-Admins` and `Marketing` groups.
2. **Policy Assignment:** Assigned the "Allowed VM SKU" policy at the Resource Group scope.
3. **RBAC Assignment:** Assigned the **Reader** role to the Marketing group and **Contributor** role to the IT-Admins group.

## Success Metrics & Verification
- [ ] Users successfully created in Entra ID.
- [ ] Attempted to deploy a `Standard_D8s_v3` VM; deployment was **denied** by policy.
- [ ] Verified that Marketing users cannot delete resources (RBAC restriction).

---
*This lab is part of my preparation for the AZ-104: Microsoft Azure Administrator certification.*
