#!/bin/bash

# This script save all relevant resources from a namespace
# to different resource yaml files depending on the resource type.

# needs the Openshift cli tool oc
# login and access to old Openshift cluster 

# Predefined list of OpenShift resource types
RESOURCE_TYPES=(
    "deployment"
    "statefulset"
    "daemonset"
    "job"
    "cronjob"
    "configmap"
    "secret"
    "service"
    "route"
    "ingress"
    "networkpolicy"
    "pvc"
    "serviceaccount"
    "role"
    "rolebinding"
    "imagestream"
    "buildconfig"

)

save_all_resources_to_yaml() {
    local namespace="$1"
    local backup_dir="${2:-.}"  # Use provided directory or default to current directory

    # Check if namespace is provided
    if [[ -z "$namespace" ]]; then
        echo "Error: Namespace is required!"
        echo "Usage: save_all_resources_to_yaml <namespace> [backup_dir]"
        exit 1
    fi

    # Ensure backup directory exists
    mkdir -p "$backup_dir"

    for resource_type in "${RESOURCE_TYPES[@]}"; do
        local output_file="${backup_dir}/${resource_type}s.yaml"  # Plural assumption

        if oc get "$resource_type" -n "$namespace" &>/dev/null; then
            oc get "$resource_type" -n "$namespace" -o yaml > "$output_file"
            echo "Saved $resource_type resources to $output_file"
        else
            echo "Warning: No resources of type '$resource_type' found in namespace '$namespace'."
        fi
    done
}

# Usage: Provide namespace and optional backup directory
save_all_resources_yaml "$1" "$2"
