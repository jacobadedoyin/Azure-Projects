# Project 1: Secure ZRS Storage Architecture

## Business Scenario
The organization requires a storage solution for sensitive diagnostic data that must remain available even during a data center failure, while being completely isolated from the public internet.

## Technical Configuration
- Redundancy: Configured as Zone-Redundant Storage (ZRS). This replicates data across three availability zones in the region.
- Network Security: Public Network Access is set to **Disabled**. 
- Connectivity: Designed for Private Link** integration to ensure all traffic remains on the Microsoft backbone.

## AZ-104 Exam Concepts Covered
- Managing Storage Redundancy (Standard_LRS vs Standard_ZRS)
- Configuring Network Access to Storage Accounts
- Implementing Virtual Networks and Subnets
- Infrastructure as Code (IaC) using Bicep
