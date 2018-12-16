#!/bin/bash

setup_install_epel()
{
  yum install -y epel-release
}

setup_install_base_utils()
{
  yum install -y unzip sshpass ansible
}

getTimestamp() {
  echo $(date -d now +%s)
}

printTimeStats()
{
    echo
    echo "----Time statistics for $HOSPITAL ----"
    echo
    echo "Started at : $(date -d @$DEPLOYMENT_START +%T)"
    echo
    echo "Ended at   : $(date -d @$DEPLOYMENT_END +%T)"
    echo
    echo -n "Elpased time : " ; date -d@$(($DEPLOYMENT_END - $DEPLOYMENT_START)) -u +%H:%M:%S ; echo
    echo
    echo "-----------------------"
    echo
}

usage="Usage: $(basename "$0") -h [hospital-name]"

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


