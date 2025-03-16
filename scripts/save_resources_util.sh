#!/bin/bash

# This script is a utility scripts and save defined resources from a namespace
# to different resource yaml files depending on the resource type.
# It's should be call from a main script with the variable RESOURCE_TYPES

# needs the Openshift cli tool oc as Variable OC_TOOL
# login and access to the old Openshift cluster 

check_namespace() {

    # Check if namespace is provided
    if [ -z "$NAMESPACE" ]; then
        echo "❌ Error: No namespace provided."
        echo "Usage: $0 <namespace>"
        exit 1
    fi
    
    # Check if the namespace exists in the cluster
    $OC_TOOL get namespace "$NAMESPACE" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "❌ Error: Namespace '$NAMESPACE' does not exist in the OpenShift cluster."
        exit 1
    else
        echo "✅ Namespace '$NAMESPACE' found in the cluster."
    fi

}

save_resources_to_yaml() {
   
    # Ensure backup directory exists
    mkdir -p "$BACKUP_DIR"

    for resource_type in "${RESOURCE_TYPES[@]}"; do
       
        # Check if a resource exists by querying for the name
        resource_names=$($OC_TOOL get "$resource_type" -n "$NAMESPACE" -o name 2>/dev/null)

        if [[ -z "$resource_names" ]]; then
            echo "No $resource_type found in namespace '$NAMESPACE'. Skipping."
            continue
        else
            local output_file="${BACKUP_DIR}/${resource_type}s.yaml"
            $OC_TOOL get "$resource_type" -n "$NAMESPACE" -o yaml > "$output_file"
            echo "Saved $resource_type resources to $output_file"
        fi

    done
}

