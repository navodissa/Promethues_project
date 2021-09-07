mode: apps9
duration: true
url: ${fqdn}/
TEST_user: TESTmonitoring
TEST_pass: ${mws_TESTmonitoring_password}
URLS:
  RESPONSE_MWS_MAIN: ${fqdn}/main/TESTapplications/web/favicon.ico
  RESPONSE_MWS_B2B10: ${fqdn}/b2b/TESTapplications/web/favicon.ico
CERTIFICATES:
  CERT_MWS_${custid}${envtype}: ${fqdn}
LABELS:
  CUSTOMERCODE: ${custid}
  ENVIRONMENTTYPE: ${envtype}
  TESTVERSION: 12.1
  INSTANCE: ${custid}-${envtype}-mw1
  EXPORTER: amm-central
HTTP:
  LOGIN: 120
  CERT_MWS_${custid}${envtype}: 86400
  RESPONSE_MWS_B2B10: 120
  RESPONSE_MWS_MAIN: 120