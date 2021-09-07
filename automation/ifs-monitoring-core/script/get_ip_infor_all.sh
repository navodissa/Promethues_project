#!/bin/bash

PREFIX="csc-mon"
ALLREGION="eu"
ENV="dev"
ALLVMSSCOMP="cassandra:TESTsrvadmin cortex:TESTsrvadmin grafana:TESTsrvadmin"
ALLVMCOMP="prometheus-1:TESTsrvadmin prometheus-2:TESTsrvadmin prometheus-3:TESTsrvadmin"
SUBSCRIPTION_ID="subscription_id"
CLIENT_ID="client_id"
CLIENT_SECRET="client_secret"
TENANT_ID="tenant_id"

RES_GP="csc-proj-tcs-moni-poc-rg"

az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET --tenant $TENANT_ID  >> /dev/null



for VMSSCOMP in $ALLVMSSCOMP; do
  COMPNAME=`echo $VMSSCOMP|cut -d : -f 1`
  echo -e "\n[$COMPNAME]" >> ../ansible/inventoryall.cfg
  USER=`echo $VMSSCOMP|cut -d : -f 2`
  for REGION in $ALLREGION; do
    VMSS="$PREFIX-$ENV-$REGION-$COMPNAME-vmss"
    IPS=`az vmss nic list --resource-group $RES_GP --vmss-name $VMSS --subscription $SUBSCRIPTION_ID| grep -w privateIpAddress|cut -d \" -f 4`
    for IP in $IPS; do
      echo -e "@$IP" >> ../ansible/inventoryall.cfg
      ssh-keygen -f "/home/gitlab-runner/.ssh/known_hosts" -R "$IP"
    done
  done
done

echo -e "\n[prometheus]" >> ../ansible/inventoryall.cfg
for VMCOMP in $ALLVMCOMP; do
  COMPNAME=`echo $VMCOMP|cut -d : -f 1`
  USER=`echo $VMCOMP|cut -d : -f 2`
  for REGION in $ALLREGION; do
    VM="$PREFIX-$ENV-$REGION-$COMPNAME-vm"
    IP=`az vm show -d --subscription $SUBSCRIPTION_ID -g $RES_GP -n $VM --query privateIps -o tsv`
    echo -e "$IP" >> ../ansible/inventoryall.cfg
    ssh-keygen -f "/home/gitlab-runner/.ssh/known_hosts" -R "$IP"
  done
done

echo -e "\n[exporter]" >> ../ansible/inventoryall.cfg
  COMPNAME="exporter"
  USER="TESTsrvadmin"
  for REGION in $ALLREGION; do
    VM="$PREFIX-$ENV-$REGION-$COMPNAME-vm"
    IP=`az vm show -d --subscription $SUBSCRIPTION_ID -g $RES_GP -n $VM --query privateIps -o tsv`
    echo -e "$IP" >> ../ansible/inventoryall.cfg
    ssh-keygen -f "/home/gitlab-runner/.ssh/known_hosts" -R "$IP"
  done

echo -e "\n[windows]" >> ../ansible/inventoryall.cfg
  COMPNAME="amm"
  USER="TESTsrvadmin"
  for REGION in $ALLREGION; do
    VM="$PREFIX-$ENV-$REGION-$COMPNAME"
    IP=`az vm show -d --subscription $SUBSCRIPTION_ID -g $RES_GP -n $VM --query privateIps -o tsv`
    echo -e "$IP" >> ../ansible/inventoryall.cfg
  
  done

Cred=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-proj-tcs-moni-poc-kv --name vm-password | grep "value" | cut -d : -f 2 | tr -d '"'`

echo -e "\n[prometheus:vars]\n" >> ../ansible/inventoryall.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventoryall.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventoryall.cfg
echo -e "ansible_password=$Cred" >> ../ansible/inventoryall.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventoryall.cfg

echo -e "\n[grafana:vars]\n" >> ../ansible/inventoryall.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventoryall.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventoryall.cfg
echo -e "ansible_password=$Cred" >> ../ansible/inventoryall.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventoryall.cfg

echo -e "\n[cassandra:vars]\n" >> ../ansible/inventoryall.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventoryall.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventoryall.cfg
echo -e "ansible_password=$Cred" >> ../ansible/inventoryall.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventoryall.cfg

echo -e "\n[cortex:vars]\n" >> ../ansible/inventoryall.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventoryall.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventoryall.cfg
echo -e "ansible_password=$Cred" >> ../ansible/inventoryall.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventoryall.cfg

echo -e "\n[exporter:vars]\n" >> ../ansible/inventoryall.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventoryall.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventoryall.cfg
echo -e "ansible_password=$Cred" >> ../ansible/inventoryall.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventoryall.cfg

echo -e "\n[windows:vars]\n" >> ../ansible/inventoryall.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventoryall.cfg
echo -e "ansible_password=$Cred" >> ../ansible/inventoryall.cfg
echo -e "ansible_connection=winrm" >> ../ansible/inventoryall.cfg
echo -e "ansible_port=5985" >> ../ansible/inventoryall.cfg
echo -e "ansible_winrm_transport=basic" >> ../ansible/inventoryall.cfg
echo -e "ansible_winrm_server_cert_validation=ignore" >> ../ansible/inventoryall.cfg
echo -e "ansible_winrm_operation_timeout_sec=240" >> ../ansible/inventoryall.cfg
echo -e "ansible_winrm_read_timeout_sec=480" >> ../ansible/inventoryall.cfg




