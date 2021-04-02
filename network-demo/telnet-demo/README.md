# Telnet demo

## Emulating an HTTP/1.1 Request using Telnet

1. HTTP server
python -m SimpleHTTPServer 53200

2. tcpdump
sudo tcpdump -i any -v port 53200

3. TCP handshake
telnet 127.0.0.1 53200

```
00:48:44.200971 IP (tos 0x10, ttl 64, id 15587, offset 0, flags [DF], proto TCP (6), length 60)
    localhost.38918 > localhost.53200: Flags [S], cksum 0xfe30 (incorrect -> 0xcdb8), seq 2818878665, win 65495, options [mss 65495,sackOK,TS val 1838438415 ecr 0,nop,wscale 7], length 0
00:48:44.201001 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TCP (6), length 60)
    localhost.53200 > localhost.38918: Flags [S.], cksum 0xfe30 (incorrect -> 0x6827), seq 2128814341, ack 2818878666, win 65483, options [mss 65495,sackOK,TS val 1838438415 ecr 1838438415,nop,wscale 7], length 0
00:48:44.201026 IP (tos 0x10, ttl 64, id 15588, offset 0, flags [DF], proto TCP (6), length 52)
    localhost.38918 > localhost.53200: Flags [.], cksum 0xfe28 (incorrect -> 0x8ee3), ack 1, win 512, options [nop,nop,TS val 1838438415 ecr 1838438415], length 0
```

4. HTTP request

```
GET / HTTP/1.1
Host: 127.0.0.1
User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)


```

```
00:51:56.499335 IP (tos 0x10, ttl 64, id 15589, offset 0, flags [DF], proto TCP (6), length 68)
    localhost.38918 > localhost.53200: Flags [P.], cksum 0xfe38 (incorrect -> 0xce06), seq 1:17, ack 1, win 512, options [nop,nop,TS val 1838630714 ecr 1838438415], length 16
00:51:56.499366 IP (tos 0x0, ttl 64, id 58754, offset 0, flags [DF], proto TCP (6), length 52)
    localhost.53200 > localhost.38918: Flags [.], cksum 0xfe28 (incorrect -> 0xb077), ack 17, win 512, options [nop,nop,TS val 1838630714 ecr 1838630714], length 0
00:52:04.299401 IP (tos 0x10, ttl 64, id 15590, offset 0, flags [DF], proto TCP (6), length 69)
    localhost.38918 > localhost.53200: Flags [P.], cksum 0xfe39 (incorrect -> 0x9818), seq 17:34, ack 1, win 512, options [nop,nop,TS val 1838638514 ecr 1838630714], length 17
00:52:04.299433 IP (tos 0x0, ttl 64, id 58755, offset 0, flags [DF], proto TCP (6), length 52)
    localhost.53200 > localhost.38918: Flags [.], cksum 0xfe28 (incorrect -> 0x7376), ack 34, win 512, options [nop,nop,TS val 1838638514 ecr 1838638514], length 0
00:52:13.091247 IP (tos 0x10, ttl 64, id 15591, offset 0, flags [DF], proto TCP (6), length 116)
    localhost.38918 > localhost.53200: Flags [P.], cksum 0xfe68 (incorrect -> 0xad16), seq 34:98, ack 1, win 512, options [nop,nop,TS val 1838647306 ecr 1838638514], length 64
00:52:13.091280 IP (tos 0x0, ttl 64, id 58756, offset 0, flags [DF], proto TCP (6), length 52)
    localhost.53200 > localhost.38918: Flags [.], cksum 0xfe28 (incorrect -> 0x2e86), ack 98, win 512, options [nop,nop,TS val 1838647306 ecr 1838647306], length 0
00:52:15.843227 IP (tos 0x10, ttl 64, id 15592, offset 0, flags [DF], proto TCP (6), length 54)
    localhost.38918 > localhost.53200: Flags [P.], cksum 0xfe2a (incorrect -> 0x16b2), seq 98:100, ack 1, win 512, options [nop,nop,TS val 1838650058 ecr 1838647306], length 2
00:52:15.843258 IP (tos 0x0, ttl 64, id 58757, offset 0, flags [DF], proto TCP (6), length 52)
    localhost.53200 > localhost.38918: Flags [.], cksum 0xfe28 (incorrect -> 0x1904), ack 100, win 512, options [nop,nop,TS val 1838650058 ecr 1838650058], length 0
00:52:15.851650 IP (tos 0x0, ttl 64, id 58758, offset 0, flags [DF], proto TCP (6), length 69)
    localhost.53200 > localhost.38918: Flags [P.], cksum 0xfe39 (incorrect -> 0x591e), seq 1:18, ack 100, win 512, options [nop,nop,TS val 1838650066 ecr 1838650058], length 17
00:52:15.851676 IP (tos 0x10, ttl 64, id 15593, offset 0, flags [DF], proto TCP (6), length 52)
    localhost.38918 > localhost.53200: Flags [.], cksum 0xfe28 (incorrect -> 0x18e3), ack 18, win 512, options [nop,nop,TS val 1838650066 ecr 1838650066], length 0
00:52:15.851725 IP (tos 0x0, ttl 64, id 58759, offset 0, flags [DF], proto TCP (6), length 90)
    localhost.53200 > localhost.38918: Flags [P.], cksum 0xfe4e (incorrect -> 0x73fb), seq 18:56, ack 100, win 512, options [nop,nop,TS val 1838650066 ecr 1838650066], length 38
00:52:15.851739 IP (tos 0x10, ttl 64, id 15594, offset 0, flags [DF], proto TCP (6), length 52)
    localhost.38918 > localhost.53200: Flags [.], cksum 0xfe28 (incorrect -> 0x18bd), ack 56, win 512, options [nop,nop,TS val 1838650066 ecr 1838650066], length 0
00:52:15.851806 IP (tos 0x0, ttl 64, id 58760, offset 0, flags [DF], proto TCP (6), length 89)
    localhost.53200 > localhost.38918: Flags [P.], cksum 0xfe4d (incorrect -> 0x6d7f), seq 56:93, ack 100, win 512, options [nop,nop,TS val 1838650066 ecr 1838650066], length 37
00:52:15.851856 IP (tos 0x0, ttl 64, id 58761, offset 0, flags [DF], proto TCP (6), length 92)
    localhost.53200 > localhost.38918: Flags [P.], cksum 0xfe50 (incorrect -> 0x4474), seq 93:133, ack 100, win 512, options [nop,nop,TS val 1838650066 ecr 1838650066], length 40
00:52:15.851900 IP (tos 0x0, ttl 64, id 58762, offset 0, flags [DF], proto TCP (6), length 74)
    localhost.53200 > localhost.38918: Flags [P.], cksum 0xfe3e (incorrect -> 0xaf05), seq 133:155, ack 100, win 512, options [nop,nop,TS val 1838650066 ecr 1838650066], length 22
00:52:15.851931 IP (tos 0x10, ttl 64, id 15597, offset 0, flags [DF], proto TCP (6), length 52)
    localhost.38918 > localhost.53200: Flags [.], cksum 0xfe28 (incorrect -> 0x185a), ack 155, win 512, options [nop,nop,TS val 1838650066 ecr 1838650066], length 0
00:52:15.852046 IP (tos 0x0, ttl 64, id 58764, offset 0, flags [DF], proto TCP (6), length 6867)
    localhost.53200 > localhost.38918: Flags [P.], cksum 0x18c8 (incorrect -> 0x3420), seq 157:6972, ack 100, win 512, options [nop,nop,TS val 1838650067 ecr 1838650066], length 6815
00:52:15.852066 IP (tos 0x10, ttl 64, id 15599, offset 0, flags [DF], proto TCP (6), length 52)
    localhost.38918 > localhost.53200: Flags [.], cksum 0xfe28 (incorrect -> 0xfdd4), ack 6972, win 482, options [nop,nop,TS val 1838650067 ecr 1838650067], length 0
00:52:15.856071 IP (tos 0x10, ttl 64, id 15600, offset 0, flags [DF], proto TCP (6), length 52)
    localhost.38918 > localhost.53200: Flags [F.], cksum 0xfe28 (incorrect -> 0xfdb0), seq 100, ack 6973, win 512, options [nop,nop,TS val 1838650071 ecr 1838650067], length 0
00:52:15.856102 IP (tos 0x0, ttl 64, id 58766, offset 0, flags [DF], proto TCP (6), length 52)
    localhost.53200 > localhost.38918: Flags [.], cksum 0xfe28 (incorrect -> 0xfdac), ack 101, win 512, options [nop,nop,TS val 1838650071 ecr 1838650071], length 0
```
