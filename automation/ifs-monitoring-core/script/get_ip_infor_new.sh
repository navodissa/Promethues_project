#!/bin/bash

az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET --tenant $TENANT_ID  >> /dev/null

rm -f ../ansible/inventory_new.cfg

for VMSSCOMP in $ALLVMSSCOMP; do
  COMPNAME=`echo $VMSSCOMP|cut -d : -f 1`
  USER=`echo $VMSSCOMP|cut -d : -f 2`

#  echo -e "\n[$COMPNAME-cluster:children]" >> ../ansible/inventory_new.cfg
#  for REGION in $ALLREGION; do
#    echo -e "[$COMPNAME-$REGION]" >> ../ansible/inventory_new.cfg
#  done

  for REGION in $ALLREGION; do
    echo -e "\n[$COMPNAME-$REGION]" >> ../ansible/inventory_new.cfg
    VMSS="$PREFIX-$ENV-$REGION-$COMPNAME-vmss"
    IPS=`az vmss nic list --resource-group $RES_GP --vmss-name $VMSS --subscription $SUBSCRIPTION_ID| grep -w privateIpAddress|cut -d \" -f 4`
    for IP in $IPS; do
      echo -e "$USER@$IP" >> ../ansible/inventory_new.cfg
      ssh-keygen -f "/home/gitlab-runner/.ssh/known_hosts" -R "$IP"
    done
  done

done

#echo -e "\n[prometheus-cluster:children]" >> ../ansible/inventory_new.cfg
#for REGION in $ALLREGION; do
#  echo -e "[prometheus-$REGION]" >> ../ansible/inventory_new.cfg
#done

for REGION in $ALLREGION; do
  echo -e "\n[prometheus-$REGION]" >> ../ansible/inventory_new.cfg
  for VMCOMP in $ALLVMCOMP; do
    COMPNAME=`echo $VMCOMP|cut -d : -f 1`
    USER=`echo $VMCOMP|cut -d : -f 2`
    VM="$PREFIX-$ENV-$REGION-$COMPNAME-vm"
    IP=`az vm show -d --subscription $SUBSCRIPTION_ID -g $RES_GP -n $VM --query privateIps -o tsv`
    echo -e "$USER@$IP" >> ../ansible/inventory_new.cfg
    ssh-keygen -f "/home/gitlab-runner/.ssh/known_hosts" -R "$IP"
  done
done

#echo -e "\n[exporter-cluster:children]" >> ../ansible/inventory_new.cfg
#for REGION in $ALLREGION; do
#  echo -e "[exporter-$REGION]" >> ../ansible/inventory_new.cfg
#done

for REGION in $ALLREGION; do
  echo -e "\n[exporter-$REGION]" >> ../ansible/inventory_new.cfg
  for VMEXP in $ALLVMEXP; do
    COMPNAME=`echo $VMEXP|cut -d : -f 1`
    USER=`echo $VMEXP|cut -d : -f 2`
    VM="$PREFIX-$ENV-$REGION-$COMPNAME-vm"
    IP=`az vm show -d --subscription $SUBSCRIPTION_ID -g $RES_GP -n $VM --query privateIps -o tsv`
    echo -e "$USER@$IP" >> ../ansible/inventory_new.cfg
    ssh-keygen -f "/home/gitlab-runner/.ssh/known_hosts" -R "$IP"
  done
done

#echo -e "\n[windows-cluster:children]" >> ../ansible/inventory_new.cfg
#for REGION in $ALLREGION; do
#  echo -e "[windows-$REGION]" >> ../ansible/inventory_new.cfg
#done

for REGION in $ALLREGION; do
  echo -e "\n[windows-$REGION]" >> ../ansible/inventory_new.cfg
  for WINEXP in $ALLWINEXP; do
    COMPNAME=`echo $WINEXP|cut -d : -f 1`
    USER=`echo $WINEXP|cut -d : -f 2`
    VM="$PREFIX-$ENV-$REGION-$COMPNAME"
    IP=`az vm show -d --subscription $SUBSCRIPTION_ID -g $RES_GP -n $VM --query privateIps -o tsv`
    echo -e "$USER@$IP" >> ../ansible/inventory_new.cfg
    ssh-keygen -f "/home/gitlab-runner/.ssh/known_hosts" -R "$IP"
  done
done

CredCassandraEU=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-mon-tst-eu-kv --name vm-cassandra-TESTsrvadmin | grep "value" | cut -d : -f 2 | tr -d '"'`

CredCortexEU=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-mon-tst-eu-kv --name vm-cortex-TESTsrvadmin | grep "value" | cut -d : -f 2 | tr -d '"'`

CredGrafanaEU=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-mon-tst-eu-kv --name vm-grafana-TESTsrvadmin | grep "value" | cut -d : -f 2 | tr -d '"'`

CredPrometheusEU=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-mon-tst-eu-kv --name vm-prometheus-TESTsrvadmin | grep "value" | cut -d : -f 2 | tr -d '"'`

CredCassandraUS=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-mon-tst-us-kv --name vm-cassandra-TESTsrvadmin | grep "value" | cut -d : -f 2 | tr -d '"'`

CredCortexUS=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-mon-tst-us-kv --name vm-cortex-TESTsrvadmin | grep "value" | cut -d : -f 2 | tr -d '"'`

CredGrafanaUS=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-mon-tst-us-kv --name vm-grafana-TESTsrvadmin | grep "value" | cut -d : -f 2 | tr -d '"'`

CredPrometheusUS=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-mon-tst-us-kv --name vm-prometheus-TESTsrvadmin | grep "value" | cut -d : -f 2 | tr -d '"'`

CredExporterEU=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-mon-tst-eu-kv --name vm-exporter-TESTsrvadmin | grep "value" | cut -d : -f 2 | tr -d '"'`

CredExporterUS=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-mon-tst-us-kv --name vm-exporter-TESTsrvadmin | grep "value" | cut -d : -f 2 | tr -d '"'`

CredWindowsEU=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-mon-tst-eu-kv --name vm-win-TESTsrvadmin | grep "value" | cut -d : -f 2 | tr -d '"'`

CredWindowsUS=`az keyvault secret show --subscription $SUBSCRIPTION_ID --vault-name csc-mon-tst-us-kv --name vm-win-TESTsrvadmin | grep "value" | cut -d : -f 2 | tr -d '"'`


echo -e "\n[prometheus-us:vars]\n" >> ../ansible/inventory_new.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory_new.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory_new.cfg
echo -e "ansible_password=$CredPrometheusUS" >> ../ansible/inventory_new.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory_new.cfg

echo -e "\n[prometheus-eu:vars]\n" >> ../ansible/inventory_new.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory_new.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory_new.cfg
echo -e "ansible_password=$CredPrometheusEU" >> ../ansible/inventory_new.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory_new.cfg

echo -e "\n[grafana-us:vars]\n" >> ../ansible/inventory_new.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory_new.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory_new.cfg
echo -e "ansible_password=$CredGrafanaUS" >> ../ansible/inventory_new.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory_new.cfg

echo -e "\n[grafana-eu:vars]\n" >> ../ansible/inventory_new.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory_new.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory_new.cfg
echo -e "ansible_password=$CredGrafanaEU" >> ../ansible/inventory_new.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory_new.cfg

echo -e "\n[cassandra-us:vars]\n" >> ../ansible/inventory_new.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory_new.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory_new.cfg
echo -e "ansible_password=$CredCassandraUS" >> ../ansible/inventory_new.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory_new.cfg

echo -e "\n[cassandra-eu:vars]\n" >> ../ansible/inventory_new.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory_new.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory_new.cfg
echo -e "ansible_password=$CredCassandraEU" >> ../ansible/inventory_new.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory_new.cfg

echo -e "\n[cortex-eu:vars]\n" >> ../ansible/inventory_new.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory_new.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory_new.cfg
echo -e "ansible_password=$CredCortexEU" >> ../ansible/inventory_new.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory_new.cfg

echo -e "\n[cortex-us:vars]\n" >> ../ansible/inventory_new.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory_new.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory_new.cfg
echo -e "ansible_password=$CredCortexUS" >> ../ansible/inventory_new.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory_new.cfg

echo -e "\n[exporter-us:vars]\n" >> ../ansible/inventory_new.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory_new.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory_new.cfg
echo -e "ansible_password=$CredExporterUS" >> ../ansible/inventory_new.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory_new.cfg

echo -e "\n[exporter-eu:vars]\n" >> ../ansible/inventory_new.cfg
echo -e "ansible_connection=ssh" >> ../ansible/inventory_new.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory_new.cfg
echo -e "ansible_password=$CredExporterEU" >> ../ansible/inventory_new.cfg
echo -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../ansible/inventory_new.cfg

echo -e "\n[windows-us:vars]\n" >> ../ansible/inventory_new.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory_new.cfg
echo -e "ansible_password=$CredWindowsUS" >> ../ansible/inventory_new.cfg
echo -e "ansible_connection=winrm" >> ../ansible/inventory_new.cfg
echo -e "ansible_port=5985" >> ../ansible/inventory_new.cfg
echo -e "ansible_winrm_transport=basic" >> ../ansible/inventory_new.cfg
echo -e "ansible_winrm_server_cert_validation=ignore" >> ../ansible/inventory_new.cfg
echo -e "ansible_winrm_operation_timeout_sec=240" >> ../ansible/inventory_new.cfg
echo -e "ansible_winrm_read_timeout_sec=480" >> ../ansible/inventory_new.cfg

echo -e "\n[windows-eu:vars]\n" >> ../ansible/inventory_new.cfg
echo -e "ansible_user=TESTsrvadmin" >> ../ansible/inventory_new.cfg
echo -e "ansible_password=$CredWindowsEU" >> ../ansible/inventory_new.cfg
echo -e "ansible_connection=winrm" >> ../ansible/inventory_new.cfg
echo -e "ansible_port=5985" >> ../ansible/inventory_new.cfg
echo -e "ansible_winrm_transport=basic" >> ../ansible/inventory_new.cfg
echo -e "ansible_winrm_server_cert_validation=ignore" >> ../ansible/inventory_new.cfg
echo -e "ansible_winrm_operation_timeout_sec=240" >> ../ansible/inventory_new.cfg
echo -e "ansible_winrm_read_timeout_sec=480" >> ../ansible/inventory_new.cfg
