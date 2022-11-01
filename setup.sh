#!/bin/bash -x

HOSTNAME=${1:-"my-lab"}
IP=${2:-"192.168.56.110"}

# bash install-docker.sh
tee 00-installer-config.yaml << EOD
network:
  ethernets:
    enp0s3:
      dhcp4: true
    enp0s8:
      dhcp4: no
      addresses: [${IP}/24]
  version: 2
EOD

sudo mv ./00-installer-config.yaml /etc/netplan/00-installer-config.yaml
sudo netplan apply

sudo sudo hostnamectl set-hostname "${HOSTNAME}"