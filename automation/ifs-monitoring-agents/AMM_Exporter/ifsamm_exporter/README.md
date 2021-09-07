## amm exporter installation

amm exporter expose TEST Application related metrics in http://%COMPUTERNAME%:9080/metrics end point and it is running as a service in the target windows VM.
amm exporter configuration can be controlled by setting below set of parameters.
First Unzip TESTamm_exporter.zip into a local folder.

## Configurations in config.yaml
Provide values for the below fields in config.yaml. 
Keep the password fields (mws_monit_pass,TEST_pass,db_pass) empty. 
TESTInstance
db_host
db_instance
db_port
db_appowner
url (ex:https://CMBGSE1907.corpnet.TESTworld.com:48080/)
admin_url (ex:http://CMBGSE1907.corpnet.TESTworld.com:48090) - Make sure we use http.
admin_port (ex:48090) - Use 48090 to use http.
pso_base_url - Base Url(without port) of PSO.
fsm_base_url - Base Url of FSM(without speciif end-points)
domain (ex:CMBGSE1907)
mws_monit_user (ex:TESTmon)
mws_monit_pass
TEST_user (ex:TESTmonitoring)
TEST_pass
db_user (ex:TESTmonitoring)
db_pass: 
pso_monit_user (ex:TESTmon)
pso_monit_pass
fsm_monit_user (ex:TESTmon)
fsm_monit_pass

##Configuring URLs
If you want to check specific url endpoints to check whether we get http rsponse code :200.
We can configure URLs section in config.yaml
1.First specify the Url Name as RESPONSE_<NAME>.(Ex:RESPONSE_BI)
2.Now specify the Url You want to check.
3.Scoll down the config.yaml and enter the Url Name entered in step 1.
4.Enter a value for the lap time which specify how often you want this url to be checked.
(Ex:RESPONSE_BI: 120)


## Configurations in TESTapp-amm.ifm
Initially UserNames/Passwords entered as plain Text in the config file and after starting the application for the first time passwords are written back as encrypted.
Open TESTapp-amm.ifm using Notepad.
$AMM_HOME: extracted Path of TESTamm_exported.zip.
Ex: $AMM_HOME=E:\TESTmon\exporters\TESTamm_exporter


## Installation Guide

1. Unzip the TESTamm_exporter.zip 
2. Setup the configuration files as mentioned above. If multiple config files are used they all reside in the $AMM_HOME\configs folder.
3. Open a CMD n Administrator mode.
4. Navigate to the director where the Zip was unzipped.  
4. Run 1. install_TESTamm_exporter_service.cmd 
   Ex: E:\TESTmon\exporters\TESTamm_exporter>install_TESTamm_exporter_service.cmd
5. Open Services window and Make Sure a New Service Has been registed as 'TEST_Application_Monitoring_Metrics'
6. Start the Service and wait for aboout 20 seconds.
7. Open a Browser and type localhost:9080/metrics
8  Press Enter and check you get the metrics page.
9. to remove amm expoerter service, run uninstall_TESTamm_exporter_service.cmd
7. To Change UserName/passwords, run TEST-application-monitoring_pw_reset.cmd 
					New_TEST_user New_TEST_password 
					New_db_user New_db_password N
					New_mws_user New_mws_password
					New_pso_user New_pso_password
					New_fsm_user New_fsm_password
