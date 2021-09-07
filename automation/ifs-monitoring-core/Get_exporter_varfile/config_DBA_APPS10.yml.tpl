mode: apps10
duration: true
db_host: ${host_name}.TESTcsc.cloud
db_instance: ${custid}${envtype}
db_port: 1521
dba_monitor_user: dbmonitor
dba_monitor_pass: ${db_password}
LABELS:
  CUSTOMERCODE: ${custid}
  ENVIRONMENTTYPE: ${envtype}
  ORACLEVERSION: 12.2
  INSTANCE: ${host_name}
  EXPORTER: amm
INFO:
  MANIFEST: 86400
DBAMETRICS:
  USER_LOGIN: SELECT 1 FROM dual
  ACCUM_LOGICAL_IO: SELECT value FROM v$sysstat WHERE name IN ('consistent gets')
  ACCUM_PHYSICAL_IO: SELECT value FROM v$sysstat WHERE name IN ('physical reads')
  ALERT_LOG: select count(*) from sys.amm_x$dbgalertext where originating_timestamp > (systimestamp-24/24) and regexp_like (message_text, '(ORA-00600)')
  BLOCKED_SESSIONS: SELECT COUNT(*) FROM v$SESSION WHERE status = 'ACTIVE' AND blocking_session is not NULL
  BLOCKED_SESSIONS_MAXWAITSECS: SELECT COALESCE(MAX(seconds_in_wait),0) FROM v$SESSION WHERE wait_time = 0 AND status = 'ACTIVE' AND blocking_session IS NOT NULL
  BLOCK_CORRUPTION: select count(*) from v$database_block_corruption dbc join dba_extents e on dbc.file# = e.file_id and dbc.block# between e.block_id and e.block_id+e.blocks-1
  BUFFER_CACHE_SIZE: SELECT BYTES/(1024*1024*1024) FROM v$sgainfo WHERE name='Buffer Cache Size'
  COMPATIBLE: SELECT COUNT(*) FROM v$version ver, v$parameter par WHERE ver.banner like '%Oracle Database%' AND par.name = 'compatible' AND substr(ver.banner,instr(ver.banner,'.',-1,4)-2,6) = par.value
  DATABASE_UPTIME: select floor((sysdate-startup_time)*24*60) from v$instance
  DATA_FILE_STATUS: select count(*) from dba_data_files where status = 'INVALID'
  DB_ACTIVE_SESSIONS: SELECT COUNT(*) FROM v$session WHERE status='ACTIVE' AND program IN ('TEST PLSQL Gateway','TEST Middleware Server Main')
  DB_BLOCKED_SESSIONS: SELECT COUNT(*) FROM v$session WHERE blocking_session IS NOT NULL
  DB_BLOCKED_SESSIONS_120S: SELECT COUNT(*) FROM v$session WHERE blocking_session IS NOT NULL and seconds_in_wait>120
  DB_BUFFER_CACHE_SIZE: SELECT bytes FROM V$SGASTAT WHERE name = 'buffer_cache'
  DB_PGA_MEMORY: SELECT value FROM v$pgastat WHERE NAME='maximum PGA allocated'
  DB_SESSIONS: SELECT COUNT(*) from v$session
  DB_SHARED_POOL_SIZE: SELECT SUM(bytes) FROM V$SGASTAT WHERE pool='shared pool'
  DEBUG_COMPILED_PACKAGES: select count(1) from (select GREATEST(plsql_debug , DECODE(plsql_optimize_level, 1, 'TRUE', 'FALSE') ) AS plsql_debug from sys.dba_plsql_object_settings where owner='TESTAPP' and plsql_debug='TRUE')
  FRA_USAGE: select case when count(*) = 0 then 0 else round((sum(space_used)/sum(space_limit))*100,0) end from v$recovery_file_dest
  INDEX_COST_ADJ: SELECT value FROM v$parameter WHERE name = 'optimizer_index_cost_adj'
  INVALID_BODIES: SELECT COUNT(*) FROM dba_objects WHERE status = 'INVALID' and object_type = 'PACKAGE BODY' and OWNER='TESTAPP'
  INVALID_DB_OBJECTS: select count(*) from dba_objects where owner='TESTAPP' and status='INVALID'
  INVALID_PACKAGES: SELECT COUNT(*) FROM dba_objects WHERE status = 'INVALID' and object_type = 'PACKAGE' and OWNER='TESTAPP'
  INVALID_TRIGGERS: SELECT COUNT(*) FROM dba_objects WHERE status = 'INVALID' and object_type = 'TRIGGER' and OWNER='TESTAPP'
  INVALID_VIEWS: SELECT COUNT(*) FROM dba_objects WHERE status = 'INVALID' and object_type = 'VIEW' and OWNER='TESTAPP'
  MEMORY_TARGET: SELECT value FROM v$parameter WHERE name = 'memory_target'
  OPTIMIZER_FEATURES_ENABLE: SELECT COUNT(*) FROM v$version ver, v$parameter par WHERE ver.banner like '%Oracle Database%' AND par.name = 'optimizer_features_enable' AND substr(banner,instr(ver.banner,'.',-1,4)-2,6)=substr(par.value,0,6)
  PACKAGES_BYTE_MODE: SELECT COUNT(*) FROM dba_plsql_object_settings WHERE nls_length_semantics = 'BYTE' and OWNER='TESTAPP'
  PGA_AGGREGATE_LIMIT: SELECT value/(1024*1024) FROM v$parameter WHERE name = 'pga_aggregate_limit'
  PLUGGABLE: SELECT sys_context('USERENV','CON_ID') FROM dual
  RMAN_BACKUP: select floor((sysdate-nvl(max(end_time),sysdate))*24*60) from v$rman_backup_job_details where input_type = 'DB FULL' and status = 'COMPLETED'
  SGA_TARGET: SELECT value FROM v$parameter  WHERE name = 'sga_target'
  SIZE_UNIFIED_AUD: select nvl(Sum(round(bytes / 1024 / 1024, 1)),0) from sys.dba_segments where owner = 'AUDSYS'
  TABLES_BYTE_MODE: SELECT COUNT(DISTINCT u.table_name) FROM dba_Tab_Columns u WHERE data_type IN ('VARCHAR2', 'CHAR') AND char_used = 'B' AND table_name NOT LIKE 'AQ$%' AND EXISTS (SELECT 1 FROM user_tables WHERE table_name = u.TABLE_NAME AND secondary = 'N') and OWNER='TESTAPP'
  TBS_TESTAPP_ARCHIVE_DATA: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100) from sys.dba_data_files where upper(tablespace_name) = 'TESTAPP_ARCHIVE_DATA'
  TBS_TESTAPP_ARCHIVE_INDEX: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100) from sys.dba_data_files where upper(tablespace_name) = 'TESTAPP_ARCHIVE_INDEX'
  TBS_TESTAPP_DATA: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100) from sys.dba_data_files where upper(tablespace_name) = 'TESTAPP_DATA'
  TBS_TESTAPP_INDEX: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100) from dba_data_files where upper(tablespace_name) = 'TESTAPP_INDEX'
  TBS_TESTAPP_LOB: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100) from sys.dba_data_files where upper(tablespace_name) = 'TESTAPP_LOB'
  TBS_TESTAPP_REPORT_DATA: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100) from sys.dba_data_files where upper(tablespace_name) = 'TESTAPP_REPORT_DATA'
  TBS_TESTAPP_REPORT_INDEX: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100) from sys.dba_data_files where upper(tablespace_name) = 'TESTAPP_REPORT_INDEX'
  TBS_SYSAUX: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100) from sys.dba_data_files where upper(tablespace_name) = 'SYSAUX'
  TBS_SYSTEM: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100) from sys.dba_data_files where upper(tablespace_name) = 'SYSTEM'
  TBS_TEMP: select round((sum(allocated_space)/sum(tablespace_size))*100) from dba_temp_free_space
  TBS_UNDOTBS: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100)from sys.dba_data_files where upper(tablespace_name) like '%UNDO%'
  TBS_TESTTAS_DATA: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100) from dba_data_files where upper(tablespace_name) = 'TESTTAS_DATA'
  TBS_TESTTAS_INDEX: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100) from dba_data_files where upper(tablespace_name) = 'TESTTAS_INDEX'
  TBS_USERS: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100) from dba_data_files where upper(tablespace_name) = 'USERS'
  DB_SIZE: select round(((sum(bytes)/1024/1024)/(sum(maxbytes)/1024/1024))*100) from dba_data_files
  CONCURRENT_USERS: select sessions_highwater from v$license
  PEAK_SCHEDULED_ACTIVITIES: select count(*) from TESTapp.deferred_job where state_db='Posted'
DBA:
  USER_LOGIN: 60
  ACCUM_LOGICAL_IO: 60
  ACCUM_PHYSICAL_IO: 60
  ALERT_LOG: 600
  BLOCKED_SESSIONS: 60
  BLOCKED_SESSIONS_MAXWAITSECS: 60
  BLOCK_CORRUPTION: 600
  BUFFER_CACHE_SIZE: 600
  COMPATIBLE: 7200
  DATABASE_UPTIME: 240
  DATA_FILE_STATUS: 240
  DB_ACTIVE_SESSIONS: 60
  DB_BLOCKED_SESSIONS: 60
  DB_BLOCKED_SESSIONS_120S: 60
  DB_BUFFER_CACHE_SIZE: 600
  DB_PGA_MEMORY: 600
  DB_SESSIONS: 60
  DB_SHARED_POOL_SIZE: 600
  DEBUG_COMPILED_PACKAGES: 600
  FRA_USAGE: 600
  INDEX_COST_ADJ: 600
  INVALID_BODIES: 600
  INVALID_DB_OBJECTS: 600
  INVALID_PACKAGES: 600
  INVALID_TRIGGERS: 600
  INVALID_VIEWS: 600
  MEMORY_TARGET: 7200
  OPTIMIZER_FEATURES_ENABLE: 600
  PACKAGES_BYTE_MODE: 600
  PGA_AGGREGATE_LIMIT: 600
  PLUGGABLE: 7200
  RMAN_BACKUP: 600
  SGA_TARGET: 7200
  SIZE_UNIFIED_AUD: 7200
  TABLES_BYTE_MODE: 600
  TBS_TESTAPP_ARCHIVE_DATA: 7200
  TBS_TESTAPP_ARCHIVE_INDEX: 7200
  TBS_TESTAPP_DATA: 7200
  TBS_TESTAPP_INDEX: 7200
  TBS_TESTAPP_LOB: 7200
  TBS_TESTAPP_REPORT_DATA: 7200
  TBS_TESTAPP_REPORT_INDEX: 7200
  TBS_SYSAUX: 7200
  TBS_SYSTEM: 7200
  TBS_TEMP: 7200
  TBS_UNDOTBS: 7200
  TBS_TESTTAS_DATA: 7200
  TBS_TESTTAS_INDEX: 7200
  TBS_USERS: 7200
  DB_SIZE: 500
  CONCURRENT_USERS: 20
  PEAK_SCHEDULED_ACTIVITIES: 300