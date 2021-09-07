export ORACLE_EXPORTER_PATH=/exporter/oracle_exporter/oracledb_exporter.0.2.9-ora18.5.linux-amd64

export ORACLE_HOME=/exporter/oracle_exporter/instantclient_18_5
export LIBDIR=/usr/lib/oracle/18_5/client64/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME:$LIBDIR
export PATH=$PATH:$LD_LIBRARY_PATH
#export DATA_SOURCE_NAME=dbmonitor/Dbmonitor1234@//10.242.199.148:1521/MONIPRD
export DEFAULT_METRICS=$ORACLE_EXPORTER_PATH/default-metrics.toml

