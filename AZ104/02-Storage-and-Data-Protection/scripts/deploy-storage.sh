#!/bin/bash

# Project 02: Storage and Data Protection
# Purpose: Provision compliant storage with WORM and Lifecycle policies

RG="AZ104-Lab"
LOC="uksouth"
NAME="adedoyinstorage2026"

echo "Provisioning Storage Account..."
az storage account create --name $NAME --resource-group $RG --location $LOC --sku Standard_LRS

echo "Applying Immutability Policy..."
az storage container immutability-policy create --account-name $NAME --container-name "data-archive" --period 180 --resource-group $RG

echo "Applying Lifecycle Policy..."
az storage account management-policy create --account-name $NAME --resource-group $RG --policy @../policies/Data-Aging-and-Cost-Optimisation-Policy.json
