#!/bin/bash

# Define colors for output
RED='\033[4;31m'
YELLOW='\033[4;33m'
CYAN='\033[4;36m'
NC='\033[0m'  # No Color

# Environment and Namespace variables (Replace these with your specific values)
ENVIRONMENT_VAR="your_environment_here"
NAMESPACE_VAR="your_namespace_here"

# Output the namespace with color formatting
printf "${RED}namespace${NC}: ${CYAN}${ENVIRONMENT_VAR}${NC}-i-bx-${YELLOW}${NAMESPACE_VAR}${NC}\n"

# Set kubectl context to the specified namespace
kubectl config set-context --current --namespace=${ENVIRONMENT_VAR}-i-bx-${NAMESPACE_VAR}