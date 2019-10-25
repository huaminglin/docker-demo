Note: "mysql" schema is not accessible, but "sys" shcema is accessible.

http://127.0.0.1:9104/metrics
# HELP mysql_exporter_collector_duration_seconds Collector time duration.
# TYPE mysql_exporter_collector_duration_seconds gauge
mysql_exporter_collector_duration_seconds{collector="collect.global_status"} 0.010134544
mysql_exporter_collector_duration_seconds{collector="collect.global_variables"} 0.028845921
mysql_exporter_collector_duration_seconds{collector="collect.info_schema.innodb_cmp"} 0.010704851
mysql_exporter_collector_duration_seconds{collector="collect.info_schema.innodb_cmpmem"} 0.000869513
mysql_exporter_collector_duration_seconds{collector="collect.info_schema.query_response_time"} 0.00126588
mysql_exporter_collector_duration_seconds{collector="collect.slave_status"} 0.031416241
mysql_exporter_collector_duration_seconds{collector="connection"} 0.004034437
