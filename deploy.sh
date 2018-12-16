#!/bin/bash
source ./deploy_functions.sh
usage="Usage: $(basename "$0")-h [hospital-name]"

while getopts "h:" opt; do
  case $opt in
    h)
      HOSPITAL=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      echo "$usage" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      echo "$usage" >&2
      exit 1
      ;;
  esac
done


INVENTORY="$HOSPITAL/inventory.inv"
PLAYBOOK="deploy_hospital.yaml"
setup_install_epel
setup_install_base_utils
DEPLOYMENT_START=$(getTimestamp)

ansible-playbook $PLAYBOOK -i $INVENTORY -e "$HOSPITAL=hospital"

DEPLOYMENT_END=$(getTimestamp)
printTimeStats


