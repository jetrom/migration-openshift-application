#!/bin/bash

# This script saves the namespace and the quota resources from that namespace
# to different resource yaml files depending on the resource type.

# needs the Openshift cli tool oc
# login and access to the old Openshift cluster 
OC_TOOL="oc"

# Predefined list of OpenShift resource types
RESOURCE_TYPES=(
    "resourcequota"
    "limitrange"
)

NAMESPACE="$1"

BACKUP_DIR="${2:-.}"  # Use provided directory or default to current directory

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$(realpath "$0")")
# import util functions
source "$SCRIPT_DIR/save_resources_util.sh"

check_namespace

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# save the namespace self as yaml
$OC_TOOL get namespace "$NAMESPACE" -o yaml > "${BACKUP_DIR}/namespace.yaml"

save_resources_to_yaml

echo "Namesspace and quota resources from $NAMESPACE saved to yaml files in $BACKUP_DIR"
