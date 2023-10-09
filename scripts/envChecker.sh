#!/bin/bash

# This script iterates through a list of namespaces, customizes the output color based on the namespace name, and lists pods that are not in 'Running' or 'Completed' state.

# Define color codes
RED='\033[4;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get environment from the first command-line argument or set a default
ENVIRONMENT=${1:-default_environment}

# List of namespaces to iterate through
NAMESPACES=("namespace1" "namespace2" "namespace3" "namespace4" "namespace5" "blue" "green" "common")

# Loop through each namespace
for NAMESPACE in ${NAMESPACES[*]}; do

  # Customize color based on the specific namespace
  if [[ $NAMESPACE == "blue" ]]; then
    echo -e "${CYAN}--------- $NAMESPACE --------- "
  elif [[ $NAMESPACE == "green" ]]; then
    echo -e "${GREEN}--------- $NAMESPACE --------- "
  elif [[ $NAMESPACE == "common" ]]; then
      echo -e "${YELLOW}--------- $NAMESPACE --------- "
  else
    echo -e "${NC}--------- $NAMESPACE --------- "
  fi

  # Fetch and display pod statuses, excluding 'Running' and 'Completed'
  kubectl get pods -n custom_prefix-${ENVIRONMENT}-i-bx-${NAMESPACE} | grep -iv Running | grep -iv completed

  # Uncomment the below line to fetch ingress resources
  #kubectl get ingress -n custom_prefix-$ENVIRONMENT-i-bx-$NAMESPACE

  echo -e ${NC}
done
