
setup_install_epel()
{
  yum install -y epel-release
}

setup_install_base_utils()
{
  yum install -y unzip sshpass ansible python2-pip
  pip install "pywinrm>=0.3.0"
}

getTimestamp() {
  echo $(date -d now +%s)
}

printTimeStats()
{
    echo
    echo "----Time statistics for $HOSPITAL ----"
    echoWa
    echo "Started at : $(date -d @$DEPLOYMENT_START +%T)"
    echo
    echo "Ended at   : $(date -d @$DEPLOYMENT_END +%T)"
    echo
    echo -n "Elpased time : " ; date -d@$(($DEPLOYMENT_END - $DEPLOYMENT_START)) -u +%H:%M:%S ; echo
    echo
    echo "-----------------------"
    echo
}


build_configuration()
{
  ansible-playbook conf.yaml -i localhost -e "hospital=$HOSPITAL" || exit $?

}
