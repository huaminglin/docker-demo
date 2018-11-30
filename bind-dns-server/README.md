## Webmin
https://127.0.0.1:10000/

Create Master Zone


## Query DNS configuration from the local DNS server
docker exec -it bind-dns-server_bind_1 bash

host google.com 127.0.0.1
Using domain server:
Name: 127.0.0.1
Address: 127.0.0.1#53
Aliases: 

google.com has address 172.217.14.110
google.com has IPv6 address 2607:f8b0:4007:80e::200e
google.com mail is handled by 50 alt4.aspmx.l.google.com.
google.com mail is handled by 20 alt1.aspmx.l.google.com.
google.com mail is handled by 30 alt2.aspmx.l.google.com.
google.com mail is handled by 10 aspmx.l.google.com.
google.com mail is handled by 40 alt3.aspmx.l.google.com.

## How to enable bind query logging to find out Who’s Querying a Name Server
rndc querylog on


