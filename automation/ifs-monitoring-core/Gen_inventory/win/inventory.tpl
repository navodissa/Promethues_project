[windows]
${host_ip_public}
[windows:vars]
ansible_user=TESTadmin
ansible_password=${admin_password}
ansible_connection=winrm
ansible_port=5986
ansible_winrm_transport=basic
ansible_winrm_server_cert_validation=ignore
ansible_winrm_operation_timeout_sec=240
ansible_winrm_read_timeout_sec=480