--  Date: 2020-02-06
--
--  Purpose: Create Prometheus Oracle user and Configure grants for monitoring
--
--  Date    Sign   History
--  ------  ----   -----------------------------------------------------------------
--  200417  HHANSE First version

-----------------------------------------------------------------------------------
SET SERVEROUTPUT ON

--    RUN AS USER SYS

define monitoringuser_ = 'dbmonitor';
define monitoringuserpwd_ = 'dbmonitor';

drop user dbmonitor;
create user &monitoringuser_ identified by &monitoringuserpwd_ default tablespace users temporary tablespace temp;
grant connect to &monitoringuser_;
grant select on v_$session to &monitoringuser_;
grant select on v_$sysstat to &monitoringuser_;
grant select on v_$database_block_corruption to &monitoringuser_;
grant select on v_$sgainfo to &monitoringuser_;
grant select on v_$pgastat to &monitoringuser_;
grant select on v_$sgastat to &monitoringuser_;
grant select on v_$parameter to &monitoringuser_;
grant select on v_$instance to &monitoringuser_;
grant select on v_$recovery_file_dest to &monitoringuser_;
grant select on v_$version to &monitoringuser_;
grant select on v_$rman_backup_job_details to &monitoringuser_;
create or replace view AMM_X$DBGALERTEXT as select * from sys.X$DBGALERTEXT;
grant select on amm_x$dbgalertext to &monitoringuser_;
grant select on dba_extents to &monitoringuser_;
grant select on dba_plsql_object_settings to &monitoringuser_;
grant select on dba_segments to &monitoringuser_;
grant select on dba_data_files to &monitoringuser_;
grant select on dba_temp_free_space to &monitoringuser_;
grant select on dba_objects to &monitoringuser_;
grant select on dba_plsql_object_settings to &monitoringuser_;
grant select on dba_tab_columns to &monitoringuser_;
grant select on TESTapp.deferred_job to &monitoringuser_;
grant select on v_$license to &monitoringuser_;



