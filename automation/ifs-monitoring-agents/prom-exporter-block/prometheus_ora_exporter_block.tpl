############################ Section Start for {{ sid }} Exporter Block ################################

  - job_name: service-azure-{{ TEST_version }}-{{ sid }}-Oracle
    scrape_interval: 300s
    scrape_timeout: 200s  
    azure_sd_configs:    
    #- environment: 'AzurePublicCloud'
    # authentication_method: 'OAuth'  
    - subscription_id: 'b7a6c70b-58cd-41d6-97cb-5e963aa0320e'
      tenant_id: 'tenant_id'      
      client_id: '{{ customer_client_id }}'
      client_secret: '{{ customer_client_secret }}'
      refresh_interval: 300s
      port: {{ oracledb_exporter_port }} 
    relabel_configs:
    - source_labels: ['__address__']
      regex: '(.*)'
      replacement: '{{ customer_code }}-{{ customer_env }}-db1'
      target_label: instance
    - source_labels: ['__meta_azure_machine_tag_cust_code']
      regex: '(.*)'
      replacement: '{{ customer_code }}'
      target_label: customercode
    - source_labels: ['__meta_azure_machine_tag_environment']
      regex: '(.*)'
      replacement: '{{ customer_env }}'
      target_label: environmenttype
    - source_labels: ['__meta_azure_subscription_id']
      regex: '(.*)'
      replacement: '$1'
      target_label: subscription_id
    - source_labels: ['__meta_azure_machine_resource_group']
      regex: '(.*)'
      replacement: '$1'
      target_label: machine_resource_group
    - source_labels: ['__meta_azure_machine_name']
      regex: '(.*)'
      replacement: '{{ customer_code }}-{{ customer_env }}-db1'
      target_label: machine_name
    - source_labels: ['__meta_azure_tenant_id']
      regex: '(.*)'
      replacement: '$1'
      target_label: tenant_id
    - source_labels: ['__meta_azure_machine_tag_application']
      regex: '.*exporter.*'
      action: keep
    - source_labels: ['__meta_azure_machine_location']
      regex: '(.*)'
      replacement: '$1'
      target_label: region
    #- source_labels: ['__meta_azure_machine_tag_customercode']
      #regex: '^$'
      #action: drop      
    #- source_labels: ['__meta_azure_machine_tag_name']
      #regex: '(.*)'
      #replacement: '$1'
      #target_label: instancename 
      
############################ Section End for {{ sid }} Exporter Block ################################
