[exporter]
${host_ip_public}


[exporter:vars]

ansible_connection=ssh
ansible_user=TESTsrvadmin
ansible_password=${admin_password}
ansible_ssh_common_args='-o StrictHostKeyChecking=no'