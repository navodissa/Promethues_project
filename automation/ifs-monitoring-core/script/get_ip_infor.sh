#!/bin/bash

az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET --tenant $TENANT_ID  >> /dev/null

rm -f ../ansible/inventory.cfg

for VMSSCOMP in $ALLVMSSCOMP; do
  COMPNAME=`echo $VMSSCOMP|cut -d : -f 1`
  if [ "$COMPNAME" != "grafana" ]; then
  echo -e "\n[$COMPNAME]" >> ../ansible/inventory.cfg
  fi
  USER=`echo $VMSSCOMP|cut -d : -f 2`
  for REGION in $ALLREGION; do
    if [ "$COMPNAME" == "grafana" ]; then
      echo -e "\n[$COMPNAME-$REGION]" >> ../ansible/inventory.cfg
    fi
    VMSS="$PREFIX-$ENV-$REGION-$COMPNAME-vmss"
    IPS=`az vmss nic list --resource-group $RES_GP --vmss-name $VMSS --subscription $SUBSCRIPTION_ID| grep -w privateIpAddress|cut -d \" -f 4`
    for IP in $IPS; do
      echo -e "$IP" >> ../ansible/inventory.cfg
      ssh-keygen -f "/home/gitlab-runner/.ssh/known_hosts" -R "$IP"
    done
  done
done

echo -e "\n[prometheus]" >> ../ansible/inventory.cfg
for VMCOMP in $ALLVMCOMP; do
  COMPNAME=`echo $VMCOMP|cut -d : -f 1`
  USER=`echo $VMCOMP|cut -d : -f 2`
  for REGION in $ALLREGION; do
    VM="$PREFIX-$ENV-$REGION-$COMPNAME-vm"
    IP=`az vm show -d --subscription $SUBSCRIPTION_ID -g $RES_GP -n $VM --query privateIps -o tsv`
    echo -e "$IP" >> ../ansible/inventory.cfg
    ssh-keygen -f "/home/gitlab-runner/.ssh/known_hosts" -R "$IP"
  done
done

echo -e "\n[exporter]" >> ../ansible/inventory.cfg
 for VMEXP in $ALLVMEXP; do
  COMPNAME=`echo $VMEXP|cut -d : -f 1`
  USER=`echo $VMEXP|cut -d : -f 2`
  for REGION in $ALLREGION; do
    VM="$PREFIX-$ENV-$REGION-$COMPNAME-vm"
    IP=`az vm show -d --subscription $SUBSCRIPTION_ID -g $RES_GP -n $VM --query privateIps -o tsv`
    echo -e "$IP" >> ../ansible/inventory.cfg
    ssh-keygen -f "/home/gitlab-runner/.ssh/known_hosts" -R "$IP"
  done
 done
  
echo -e "\n[windows]" >> ../ansible/inventory.cfg
for WINEXP in $ALLWINEXP; do
  COMPNAME=`echo $WINEXP|cut -d : -f 1`
  USER=`echo $WINEXP|cut -d : -f 2`
  for REGION in $ALLREGION; do
    VM="$PREFIX-$ENV-$REGION-$COMPNAME"
    IP=`az vm show -d --subscription $SUBSCRIPTION_ID -g $RES_GP -n $VM --query privateIps -o tsv`
    echo -e "$IP" >> ../ansible/inventory.cfg
  done
done

Cred=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-ops-tst-moni-euwe-kv --name vm-password | grep "value" | cut -d : -f 2 | tr -d '"'`

echo -e "\n[prometheus:vars]\n" >> ../ansible/inventory.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory.cfg
echo -e "ansible_password=$Cred" >> ../ansible/inventory.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory.cfg

echo -e "\n[grafana-us:vars]\n" >> ../ansible/inventory.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory.cfg
echo -e "ansible_password=$Cred" >> ../ansible/inventory.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory.cfg

echo -e "\n[grafana-eu:vars]\n" >> ../ansible/inventory.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory.cfg
echo -e "ansible_password=$Cred" >> ../ansible/inventory.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory.cfg

echo -e "\n[cassandra:vars]\n" >> ../ansible/inventory.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory.cfg
echo -e "ansible_password=$Cred" >> ../ansible/inventory.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory.cfg

echo -e "\n[cortex:vars]\n" >> ../ansible/inventory.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory.cfg
echo -e "ansible_password=$Cred" >> ../ansible/inventory.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory.cfg

echo -e "\n[exporter:vars]\n" >> ../ansible/inventory.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory.cfg
echo -e "ansible_password=$Cred" >> ../ansible/inventory.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory.cfg

echo -e "\n[windows:vars]\n" >> ../ansible/inventory.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory.cfg
echo -e "ansible_password=$Cred" >> ../ansible/inventory.cfg
echo -e "ansible_connection=winrm" >> ../ansible/inventory.cfg
echo -e "ansible_port=5985" >> ../ansible/inventory.cfg
echo -e "ansible_winrm_transport=basic" >> ../ansible/inventory.cfg
echo -e "ansible_winrm_server_cert_validation=ignore" >> ../ansible/inventory.cfg
echo -e "ansible_winrm_operation_timeout_sec=240" >> ../ansible/inventory.cfg
echo -e "ansible_winrm_read_timeout_sec=480" >> ../ansible/inventory.cfg




