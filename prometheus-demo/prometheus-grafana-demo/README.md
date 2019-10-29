## Prometheus: Status > Targets
http://127.0.0.1:9090/targets

## grafana grafana.ini
docker cp prometheus-grafana-demo_grafana_1:/etc/grafana/grafana.ini /tmp

Configure admin_password in grafana.ini, then Grafana will not ask you to change password on the first login.
admin_password = password

## grafana
http://localhost:3000/login
admin/admin

## Use provisioning to load a datasource by config file:
Step 1: Use "grafana/datasources.yaml" to search sample yml on the Internet.

Step 2: Edit the config file for Grafana DataSource Provisioning
prometheus-grafana-demo/grafana/provisioning/datasources/datasource.yml

Step 3: Restart the server and validate configured datasource
http://127.0.0.1:3000/datasources
This datasource was added by config and cannot be modified using the UI. Please contact your server admin to update this datasource.

Step 4: Check recommended dashboards for a given datasource:
http://127.0.0.1:3000/datasources/edit/1/dashboards

## Use provisioning to load a dashboard by config file:
http://127.0.0.1:3000/dashboards

Step 1: add a dashboard with Grafana Admin UI

Step 2: Get the Dashboard json modle value as a file
Grafana Dashboard View Page > Dashboard Settings > JSON Model
The JSON model value can be saved as a JSON file for Grafana Dashboard Provisioning

Step 3: Save the value to prometheus-grafana-demo/dashboards/PrometheusStats.json
Note: In the file, the previous datasource name has already been binded.

Step 4: Config Grafana to load dashboards from dashboards/ folder:
/prometheus-grafana-demo/grafana/provisioning/datasources/datasource.yml

Step 5: Restart the server and validate the configured dashboard.

## Check database of Grafana
docker cp prometheus-grafana-demo_grafana_1:/var/lib/grafana/grafana.db /tmp
