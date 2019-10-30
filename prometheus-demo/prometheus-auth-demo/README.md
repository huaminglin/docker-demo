## Prometheus can be visited directly
http://localhost:9090/

## Use a reverse proxy and basic authentication to protect prometheus
htpasswd -bc user.wd admin admin

http://localhost:8090/
admin/admin
