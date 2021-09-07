mode: apps9
duration: true
admin_port: ${adminport}
domain: ${host_ip_local}
admin_url: http://${host_ip_local}:${adminport}/
url: ${fqdn}/
mws_monit_user: TESTmon
mws_monit_pass: ${mws_TEST_password}
CERTIFICATES:
  CERT_MWS_${custid}${envtype}: ${fqdn}  
LABELS:
  CUSTOMERCODE: ${custid}
  ENVIRONMENTTYPE: ${envtype}
  TESTVERSION: 12.1
  INSTANCE: ${custid}-${envtype}-mw1
  EXPORTER: amm
HTTP:
  CERT_MWS_${custid}${envtype}: 86400
MWS:
  USER_LOGIN: 600
  FNDBAS_STATUS: 600
  FNDBASXA_STATUS: 600
  FNDBAS_CURRCAPACITY: 600
  FNDBASXA_CURRCAPACITY: 600
  FNDBAS_CURRENT_COUNT: 600
  FNDBASXA_CURRENT_COUNT: 600
  FNDBAS_AVG_WAIT: 600
  FNDBASXA_AVG_WAIT: 600
  PLSQL_SWITCH_USER_PERCENTAGE: 600
  PLSQL_WAITED_REQUESTS_PERCENTAGE: 600
  STUCK_THREADS: 120
  HEALTHSTATEID: 60
  JAVA_MEMORY_USAGE: 120
  APPLICATIONS_STARTED: 3600
