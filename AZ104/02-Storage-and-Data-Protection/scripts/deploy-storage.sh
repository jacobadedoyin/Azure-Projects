#!/bin/bash

# ==============================================================================
# Script Name: deploy-storage.sh
# Description: Provisions a compliant Azure Storage solution with WORM (Immutability)
#              and Automated Lifecycle Management policies.
# Author:      Jacob Adedoyin
# ==============================================================================

# Stop script on first error
set -e

# --- Variables ---
RG_NAME="AZ104-Lab"
LOCATION="uksouth"
# Generate a unique name: "st" + "adedoyin" + random number
STORAGE_NAME="stadedoyin$RANDOM" 
CONTAINER_NAME="data-archive"
POLICY_FILE="../policies/Data-Aging-and-Cost-Optimisation-Policy.json"

# --- Formatting ---
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}--- ☁️ Starting Storage Deployment ---${NC}"

# 1. Create Resource Group (Idempotent)
echo -e "${CYAN}[1/5] Checking Resource Group...${NC}"
az group create --name "$RG_NAME" --location "$LOCATION" -o none
echo -e "${GREEN}   [✔] Resource Group '$RG_NAME' is ready.${NC}"

# 2. Create Storage Account (GPv2, LRS)
echo -e "${CYAN}[2/5] Provisioning Storage Account: $STORAGE_NAME...${NC}"
# Check if exists first to avoid error
if ! az storage account show --name "$STORAGE_NAME" --resource-group "$RG_NAME" &>/dev/null; then
    az storage account create \
        --name "$STORAGE_NAME" \
        --resource-group "$RG_NAME" \
        --location "$LOCATION" \
        --sku Standard_LRS \
        --kind StorageV2 \
        --allow-blob-public-access false \
        -o none
    echo -e "${GREEN}   [✔] Storage Account created.${NC}"
else
    echo -e "${GREEN}   [✔] Storage Account already exists.${NC}"
fi

# 3. Create the Container (Critical Step missing in original)
echo -e "${CYAN}[3/5] Creating Container: $CONTAINER_NAME...${NC}"
# Use --auth-mode login to demonstrate Zero Trust/RBAC usage
az storage container create \
    --account-name "$STORAGE_NAME" \
    --name "$CONTAINER_NAME" \
    --auth-mode login \
    -o none
echo -e "${GREEN}   [✔] Container created.${NC}"

# 4. Apply Immutability Policy (WORM)
echo -e "${CYAN}[4/5] Applying Immutability Policy (180 Days)...${NC}"
az storage container immutability-policy create \
    --account-name "$STORAGE_NAME" \
    --container-name "$CONTAINER_NAME" \
    --period 180 \
    --resource-group "$RG_NAME" \
    -o none
echo -e "${GREEN}   [✔] WORM Policy enforced.${NC}"

# 5. Apply Lifecycle Management Policy
echo -e "${CYAN}[5/5] Applying Lifecycle Rules...${NC}"
if [ -f "$POLICY_FILE" ]; then
    az storage account management-policy create \
        --account-name "$STORAGE_NAME" \
        --resource-group "$RG_NAME" \
        --policy "@$POLICY_FILE" \
        -o none
    echo -e "${GREEN}   [✔] Lifecycle Policy applied successfully.${NC}"
else
    echo -e "\033[0;31m   [X] Error: Policy file not found at $POLICY_FILE${NC}"
    exit 1
fi

echo -e "${GREEN}--- ✅ Deployment Complete ---${NC}"
echo -e "Storage Account Name: $STORAGE_NAME"
