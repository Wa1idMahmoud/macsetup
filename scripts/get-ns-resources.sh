#!/bin/env bash

# Default values for Cluster and Namespace (Replace these with your specific values)
CLUSTER=${2:-default_cluster}
NS=${1:-default_namespace}

# Construct the Namespace based on the Cluster and Namespace variables
NAMESPACE=custom_prefix-$CLUSTER-i-bx-$NS

# Define the context (Replace 'your_context_here' with your specific context)
CONTEXT=your_context_here

# Get the list of Kubernetes resources in the namespace
RESOURCES=($(kubectl api-resources --context=$CONTEXT --namespace=$NAMESPACE --namespaced=true | awk '{print $1}'))

# Loop through each resource and get its details
for RESOURCE in "${RESOURCES[@]}"
do
    echo "$RESOURCE in $NAMESPACE..."
    kubectl get $RESOURCE --context=$CONTEXT --namespace=$NAMESPACE
    echo
done
