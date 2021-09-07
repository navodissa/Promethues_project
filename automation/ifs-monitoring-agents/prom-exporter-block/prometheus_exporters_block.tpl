############################ Section Start for {{ customer_code }} Exporter Block################################

  - job_name: service-azure-{{ TEST_version }}-{{ customer_code }}-WMI
    azure_sd_configs:    
    #- environment: 'AzurePublicCloud'
    # authentication_method: 'OAuth'  
    - subscription_id: '{{ customer_subscription_id }}'
      tenant_id: 'tenant_id'      
      client_id: '{{ customer_client_id }}'
      client_secret: '{{ customer_client_secret }}'
      refresh_interval: 300s
      port: 9182 
    relabel_configs:
    - source_labels: ['__meta_azure_machine_name']
      regex: '(.*)'
      replacement: '$1'
      target_label: instance
    - source_labels: ['__meta_azure_machine_tag_customercode']
      regex: '(.*)'
      replacement: '$1'
      target_label: customercode
    - source_labels: ['__meta_azure_machine_tag_environmenttype']
      regex: '(.*)'
      replacement: '$1'
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
      replacement: '$1'
      target_label: machine_name
    - source_labels: ['__meta_azure_tenant_id']
      regex: '(.*)'
      replacement: '$1'
      target_label: tenant_id
    - source_labels: ['__meta_azure_machine_location']
      regex: '(.*)'
      replacement: '$1'
      target_label: region
    #- source_labels: ['__meta_azure_machine_tag_prometheus']
      #regex: '.*wmi.*'
     # action: keep
    #- source_labels: ['__meta_azure_machine_tag_customercode']
      #regex: '^$'
      #action: drop      
    - source_labels: ['__meta_azure_machine_tag_TEST_version']
      regex: '(.*)'
      replacement: '$1'
      target_label: TEST_version
    - source_labels: ['__meta_azure_machine_tag_TESTrole']
      regex: '(.*)'
      replacement: '$1'
      target_label: hostgroup
    - source_labels: ['__address__']
      regex: '(.*)'
      replacement: wmi
      target_label: exporter


  - job_name: service-azure-{{ TEST_version }}-{{ customer_code }}-MSSQL
    azure_sd_configs:    
    #- environment: 'AzurePublicCloud'
    # authentication_method: 'OAuth'  
    - subscription_id: '{{ customer_subscription_id }}'
      tenant_id: 'tenant_id'      
      client_id: '{{ customer_client_id }}'
      client_secret: '{{ customer_client_secret }}'
      refresh_interval: 300s
      port: 18080 
    relabel_configs:
            #- source_labels: ['__address__']
            #regex: '([^:]+):\d+'
            #replacement: '$1'
            #target_label: instance
    - source_labels: ['__meta_azure_machine_tag_customercode']
      regex: '(.*)'
      replacement: '$1'
      target_label: customercode
    - source_labels: ['__meta_azure_machine_tag_environmenttype']
      regex: '(.*)'
      replacement: '$1'
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
      replacement: '$1'
      target_label: machine_name
    - source_labels: ['__meta_azure_tenant_id']
      regex: '(.*)'
      replacement: '$1'
      target_label: tenant_id
    - source_labels: ['__meta_azure_machine_name']
      regex: '(.*)'
      replacement: '$1'
      target_label: instance 
    - source_labels: ['__meta_azure_machine_location']
      regex: '(.*)'
      replacement: '$1'
      target_label: region
    #- source_labels: ['__meta_azure_machine_tag_prometheus']
      #regex: '.*mssql.*'
     # action: keep
    #- source_labels: ['__meta_azure_machine_tag_customercode']
      #regex: '^$'
      #action: drop      
    - source_labels: ['__meta_azure_machine_TEST_version']
      regex: '(.*)'
      replacement: '$1'
      target_label: TEST_version 
    - source_labels: ['__address__']
      regex: '(.*)'
      replacement: mssql
      target_label: exporter

  - job_name: service-azure-{{ TEST_version }}-{{ customer_code }}-CentralAMM
    honor_labels: true
    azure_sd_configs:
    #- environment: 'AzurePublicCloud'
    # authentication_method: 'OAuth'
    - subscription_id: 'b7a6c70b-58cd-41d6-97cb-5e963aa0320e'
      tenant_id: 'tenant_id'      
      client_id: '{{ customer_client_id }}'
      client_secret: '{{ customer_client_secret }}'
      refresh_interval: 300s
      port: 9080
    relabel_configs:
            #- source_labels: ['__address__']
            # regex: '([^:]+):\d+'
            # replacement: '$1'
            # target_label: instance
    - source_labels: ['__meta_azure_machine_tag_cust_code']
      regex: '(.*)'
      replacement: '$1'
      target_label: customercode
    - source_labels: ['__meta_azure_machine_tag_environment']
      regex: '(.*)'
      replacement: '$1'
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
      replacement: '$1'
      target_label: machine_name
    - source_labels: ['__meta_azure_tenant_id']
      regex: '(.*)'
      replacement: '$1'
      target_label: tenant_id
    - source_labels: ['__meta_azure_machine_tag_application']
      regex: '.*AMM.*'
      action: keep
    - source_labels: ['__meta_azure_machine_name']
      regex: '(.*)'
      replacement: '$1'
      target_label: instance
    - source_labels: ['__meta_azure_machine_location']
      regex: '(.*)'
      replacement: '$1'
      target_label: region
    - source_labels: ['__address__']
      regex: '(.*)'
      replacement: amm
      target_label: exporter 
     #- source_labels: ['__meta_azure_machine_tag_customercode']
      #regex: '^$'
      #action: drop      
    #- source_labels: ['__meta_azure_machine_tag_name']
      #regex: '(.*)'
      #replacement: '$1'
      #target_label: instancename

  - job_name: service-azure-{{ TEST_version }}-{{ customer_code }}-CustomerAMM-MWS
    honor_labels: true
    azure_sd_configs:
    #- environment: 'AzurePublicCloud'
    # authentication_method: 'OAuth'
    - subscription_id: '{{ customer_subscription_id }}'
      tenant_id: 'tenant_id'      
      client_id: '{{ customer_client_id }}'
      client_secret: '{{ customer_client_secret }}'
      refresh_interval: 300s
      port: 9080
    relabel_configs:
            #- source_labels: ['__address__']
            # regex: '([^:]+):\d+'
            # replacement: '$1'
            # target_label: instance
    - source_labels: ['__meta_azure_machine_tag_customercode']
      regex: '(.*)'
      replacement: '$1'
      target_label: customercode
    - source_labels: ['__meta_azure_machine_tag_environmenttype']
      regex: '(.*)'
      replacement: '$1'
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
      replacement: '$1'
      target_label: machine_name
    - source_labels: ['__meta_azure_machine_location']
      regex: '(.*)'
      replacement: '$1'
      target_label: region
    - source_labels: ['__meta_azure_tenant_id']
      regex: '(.*)'
      replacement: '$1'
      target_label: tenant_id
    #- source_labels: ['__meta_azure_machine_tag_application']
      #regex: '.*AMM.*'
      #action: keep
    - source_labels: ['__meta_azure_machine_name']
      regex: '(.*)'
      replacement: '$1'
      target_label: instance
    - source_labels: ['__address__']
      regex: '(.*)'
      replacement: amm-mws
      target_label: exporter 
    #- source_labels: ['__meta_azure_machine_tag_customercode']
      #regex: '^$'
      #action: drop      
    #- source_labels: ['__meta_azure_machine_tag_name']
      #regex: '(.*)'
      #replacement: '$1'
      #target_label: instancename  

  - job_name: service-azure-{{ TEST_version }}-{{ customer_code }}-IIS
    azure_sd_configs:
    #- environment: 'AzurePublicCloud'
    # authentication_method: 'OAuth'
    - subscription_id: '{{ customer_subscription_id }}'
      tenant_id: 'tenant_id'      
      client_id: '{{ customer_client_id }}'
      client_secret: '{{ customer_client_secret }}'
      refresh_interval: 300s
      port: 9115
    relabel_configs:
            #- source_labels: ['__address__']
            # regex: '([^:]+):\d+'
            #replacement: '$1'
            #target_label: instance
    - source_labels: ['__meta_azure_machine_tag_customercode']
      regex: '(.*)'
      replacement: '$1'
      target_label: customercode
    - source_labels: ['__meta_azure_machine_tag_environmenttype']
      regex: '(.*)'
      replacement: '$1'
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
      replacement: '$1'
      target_label: machine_name
    - source_labels: ['__meta_azure_tenant_id']
      regex: '(.*)'
      replacement: '$1'
      target_label: tenant_id
    - source_labels: ['__meta_azure_machine_name']
      regex: '(.*)'
      replacement: '$1'
      target_label: instance
    - source_labels: ['__meta_azure_machine_location']
      regex: '(.*)'
      replacement: '$1'
      target_label: region
    - source_labels: ['__address__']
      regex: '(.*)'
      replacement: iis
      target_label: exporter 
    #- source_labels: ['__meta_azure_machine_tag_prometheus']
      #regex: '.*nginx.*'
      #action: keep
    #- source_labels: ['__meta_azure_machine_tag_customercode']
      #regex: '^$'
      #action: drop      
    - source_labels: ['__meta_azure_machine_TEST_version']
      regex: '(.*)'
      replacement: '$1'
      target_label: TEST_version
          
  - job_name: service-azure-{{ TEST_version }}-{{ customer_code }}-AzureMetric
    azure_sd_configs:    
    #- environment: 'AzurePublicCloud'
    # authentication_method: 'OAuth'  
    - subscription_id: 'b7a6c70b-58cd-41d6-97cb-5e963aa0320e'
      tenant_id: 'tenant_id'      
      client_id: '{{ customer_client_id }}'
      client_secret: '{{ customer_client_secret }}'
      refresh_interval: 300s
      port: 9276 
    relabel_configs:
    - source_labels: ['__meta_azure_machine_name']
      regex: '(.*)'
      replacement: '$1'
      target_label: instance
    - source_labels: ['__meta_azure_machine_tag_cust_code']
      regex: '(.*)'
      replacement: '$1'
      target_label: customercode
    - source_labels: ['__meta_azure_machine_tag_environment']
      regex: '(.*)'
      replacement: '$1'
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
      replacement: '$1'
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
    - source_labels: ['__address__']
      regex: '(.*)'
      replacement: azuremetric
      target_label: exporter 
    #- source_labels: ['__meta_azure_machine_tag_customercode']
      #regex: '^$'
      #action: drop      
    #- source_labels: ['__meta_azure_machine_tag_name']
      #regex: '(.*)'
      #replacement: '$1'
      #target_label: instancename    
    metric_relabel_configs:
    - source_labels: [resource_name]
      regex: '(.*)'
      replacement: '$1'
      target_label: instance 
      
############################ Section End for {{ customer_code }} Exporter Block################################
