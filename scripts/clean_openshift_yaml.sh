#!/bin/bash

# removes all dynamically generated field and metadata
# from the saved resource yaml file  
# input path backup directory
# yq tool needs to be installed and accessible

# Directory containing the resource YAML files
BACKUP_DIR="${1:-.}"  # Default to the current directory if not provided

# Ensure the backup directory exists
if [[ ! -d "$BACKUP_DIR" ]]; then
    echo "Error: Backup directory '$BACKUP_DIR' does not exist!"
    exit 1
fi

echo "Cleaning OpenShift-generated fields from YAML files in: $BACKUP_DIR"

# List of fields to remove from the yaml resources
FIELDS_TO_REMOVE=(
    "creationTimestamp"
    "resourceVersion"
    "uid"
    "status"
    "selfLink"
    "generation"
    "managedFields"
)

# Process all YAML files in the backup directory
for file in "$BACKUP_DIR"/*.yaml; do
    if [[ -f "$file" ]]; then
        echo "Cleaning $file..."
        
        # Use yq to remove the unwanted fields
        for field in "${FIELDS_TO_REMOVE[@]}"; do
            yq -i "del(.. | select(has(\"$field\")))" "$file"
        done
    fi
done

echo "Cleanup complete!"
