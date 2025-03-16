# Migration of an application to a new openshift cluster

Constains how-tos and scripts for the migrations of an application in a namespace of an Openshift cluster.

## Backup all relevant resources of this appplication
If resources where created in the old cluster via the Openshift UI and not saved in yaml files then all theses resources have to be downloaded as yaml files.
These resource yaml files contain fields and metadata generated dynamically by Openshift during the deployment and should be removed.

The following script: [save_all_resources_to_yaml.sh](./scripts/save_all_resources_to_yaml.sh) does this.
It requires the cli oc and a succesful login to the Openshift cluster.

These resource yaml files contain additional fields and metadata dynamically generated by Openshift during deployment.
These can be removed and are not necessary for the new cluster.
The following script [clean_openshift_yaml](./scripts/clean_openshift_yaml.sh) can be used for the clean up.
