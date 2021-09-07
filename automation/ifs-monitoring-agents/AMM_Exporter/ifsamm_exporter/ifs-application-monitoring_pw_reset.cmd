@echo Off
IF "%~1" == "" GOTO error
IF "%~2" == "" GOTO error
IF "%~3" == "" GOTO error
IF "%~4" == "" GOTO error
IF "%~5" == "" GOTO error
IF "%~6" == "" GOTO error
IF "%~7" == "" GOTO error
IF "%~8" == "" GOTO error
IF "%~9" == "" GOTO error
IF "%~10" == "" GOTO error
start java\jdk-11.0.2\bin\java -jar TEST-application-monitoring_pw_reset.jar "config.yaml" %1 %2 %3 %4 %5 %6 %7 %8 %9 %10
echo user-name/password reset successful!
pause
EXIT /B
:error
  echo usage: reset_amm_pwd.cmd TEST_user TEST_password db_user db_password mws_user mws_password pso_user pso_password fsm_user fsm_password
pause