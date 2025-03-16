#!/bin/bash

# This script saves all relevant resources from a namespace
# to different resource yaml files depending on the resource type.

# needs the Openshift cli tool oc
# login and access to the old Openshift cluster 
OC_TOOL="oc"


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

NAMESPACE="$1"

BACKUP_DIR="${2:-.}"  # Use provided directory or default to current directory

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$(realpath "$0")")
# import util functions
source "$SCRIPT_DIR/save_resources_util.sh"

check_namespace

save_resources_to_yaml

echo "All resources from $NAMESPACE saved to yaml files in $BACKUP_DIR"
