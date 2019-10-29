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

## Prometheus: Status > Targets
http://127.0.0.1:9090/targets

## grafana
http://localhost:3000/
admin/password

## Mysql - Prometheus
https://grafana.com/grafana/dashboards/6239
Basic Mysql dashboard for the prometheus exporter

Step 1: Improve the mysql dashboard with Grafana Web GUI

Step 2: Save the JSON Model as mysql-prometheus.json
http://localhost:3000/d/6-kPlS7ik/mysql-prometheus?editview=dashboard_json&orgId=1

Step 3: Use Grafana Dashboard Provisioning to load mysql-prometheus.json

## Connect to MySQL Server with a remote client to verify the dashboard's update of MySQL activities
