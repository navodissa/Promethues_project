- targets: ['10.241.106.21:48093']
  labels:
      instance: 'msad-ppr-mw1'
      name: 'mws node manager'
      port: '48093'
      customercode: 'msad'
      environmenttype: 'ppr'
      region: 'westeurope'

- targets: ['10.241.106.21:48090']
  labels:
      instance: 'msad-ppr-mw1'
      name: 'mws admin server'
      port: '48090'
      customercode: 'msad'
      environmenttype: 'ppr'
      region: 'westeurope'
     
- targets: ['10.241.106.21:48200']
  labels:
      instance: 'msad-ppr-mw1'
      name: 'managed server'
      port: '48200'
      customercode: 'msad'
      environmenttype: 'ppr'
      region: 'westeurope'

- targets: ['10.241.106.21:48080']
  labels:
      instance: 'msad-ppr-mw1'
      name: 'mws ohs http'
      port: '48080'
      customercode: 'msad'
      environmenttype: 'ppr'
      region: 'westeurope'

