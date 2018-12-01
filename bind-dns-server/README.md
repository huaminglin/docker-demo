## Webmin
https://127.0.0.1:10000/
Creating a domain using webmin
1) Servers > BIND DNS Server > Create master zone
Next, we create the forward zone example.com by selecting Create master zone and in the Create new zone dialog set the Zone type to Forward, the Domain Name to example.com, the Master server to ns.example.com and set Email address to the domain administrator’s email address and select Create.

Now there will be one Name Server in the example.com zone.
cat /data/bind/etc/named.conf.local
zone "example.com" {
	type master;
	file "/var/lib/bind/example.com.hosts";
	};

cat /var/lib/bind/example.com.hosts
$ttl 38400
example.com.	IN	SOA	ns.example.com. admin.example.com. (
			1543648995
			10800
			3600
			604800
			38400 )
example.com.	IN	NS	ns.example.com.

2) Servers > BIND DNS Server > Existing DNS Zones: example.com; 
Edit Master Zone > Address: ns -> 172.42.5.3
Note: this configuration item is required. Otherwise the step 3) can't take effect.

3) Servers > BIND DNS Server > Existing DNS Zones: example.com; 
Edit Master Zone > Address: webserver -> 192.168.2.122

cat /var/lib/bind/example.com.hosts
$ttl 38400
example.com.	IN	SOA	ns.example.com. admin.example.com. (
			1543648996
			10800
			3600
			604800
			38400 )
example.com.	IN	NS	ns.example.com.
webserver.example.com.	IN	A	192.168.2.122

4) Apply the configuration.
5) host webserver.example.com 127.0.0.1
Using domain server:
Name: 127.0.0.1
Address: 127.0.0.1#53
Aliases: 

webserver.example.com has address 192.168.2.122

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
host sina.com 127.0.0.1

docker logs bind-dns-server_bind_1
01-Dec-2018 07:44:20.613 received control channel command 'querylog on'
01-Dec-2018 07:44:20.613 query logging is now on
01-Dec-2018 07:44:41.818 client @0x7f653010ee90 127.0.0.1#57488 (sina.com): query: sina.com IN A + (127.0.0.1)
01-Dec-2018 07:44:43.257 address not available resolving 'ns2.sina.com.cn/AAAA/IN': 2001:dc7::1#53
01-Dec-2018 07:44:43.257 address not available resolving 'ns2.sina.com.cn/AAAA/IN': 2001:dc7:1000::1#53
01-Dec-2018 07:44:43.267 address not available resolving 'ns1.sina.com.cn/A/IN': 2001:dc7:1000::1#53
01-Dec-2018 07:44:43.303 client @0x7f65301572f0 127.0.0.1#34692 (sina.com): query: sina.com IN AAAA + (127.0.0.1)
01-Dec-2018 07:44:43.312 client @0x7f653012bc40 127.0.0.1#47827 (sina.com): query: sina.com IN MX + (127.0.0.1)
