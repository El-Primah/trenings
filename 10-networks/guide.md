
```
docker network create network-A
docker network create network-B
docker network create network-C

docker run -d --name c1-A --network network-A --cap-add=NET_ADMIN alpine:3.22 sleep infinity 
docker run -d --name c2-B --network network-B --cap-add=NET_ADMIN alpine:3.22 sleep infinity
docker run -d --name c3-C --network network-C --cap-add=NET_ADMIN alpine:3.22 sleep infinity
```
<img width="809" height="93" alt="image" src="https://github.com/user-attachments/assets/2f6c2359-6f2f-4f43-8347-8591fe241eeb" />

### инфа о сетях
```
 docker network inspect network-A network-B network-C
[
    {
        "Name": "network-A",
        "Id": "d2b23737a73c106eab2dacb85a4b88a7ac00107fdb31ad6ebde6a057c2056000",
        "Created": "2025-08-11T15:14:32.519218878+05:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.21.0.0/16",
                    "Gateway": "172.21.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "32581443b145c4af2c926d39ea07dadb98477278ca230cb75fa864a45a7e2bbc": {
                "Name": "r1-AB",
                "EndpointID": "c2f9d084a663434d6d3680c6e0af4704a43f1393fcfc1e965a42c6c1a6fb759a",
                "MacAddress": "02:42:ac:15:00:03",
                "IPv4Address": "172.21.0.3/16",
                "IPv6Address": ""
            },
            "c25917ea39f6254f4e8d6993d9d4a8ba780d99578cfa6349c1681bf2b78d6eab": {
                "Name": "c1-A",
                "EndpointID": "d570eee5b7648855fc47a514a5ec6306df26be20e3762177b3bbae7e483559ee",
                "MacAddress": "02:42:ac:15:00:02",
                "IPv4Address": "172.21.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    },
    {
        "Name": "network-B",
        "Id": "6e824af968b0a444ab880c5b29e6184e5b14cc34e28a606abac65131ad8976b5",
        "Created": "2025-08-11T15:14:34.774970048+05:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.22.0.0/16",
                    "Gateway": "172.22.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "32581443b145c4af2c926d39ea07dadb98477278ca230cb75fa864a45a7e2bbc": {
                "Name": "r1-AB",
                "EndpointID": "ab5827dde968cb8899bb408ed11138fad15fa97be400095203579f4af889e330",
                "MacAddress": "02:42:ac:16:00:03",
                "IPv4Address": "172.22.0.3/16",
                "IPv6Address": ""
            },
            "75c1bcdfa75e84eff98776609041952a92209a536a685a1fedd2bb49561bceae": {
                "Name": "r2-BC",
                "EndpointID": "57b0072f83963a410daee2ad12e4db93850a12d81718bfa1f85483ac0594c1ba",
                "MacAddress": "02:42:ac:16:00:04",
                "IPv4Address": "172.22.0.4/16",
                "IPv6Address": ""
            },
            "aa31df12b00f9de40d2b0bce5ac2cc38db2d46fc4906b5c62734b60f4aaf98db": {
                "Name": "c2-B",
                "EndpointID": "d872683a40e4a4517dba83f5b096db6c6970dc575b5d966636021f0fdfcb85ac",
                "MacAddress": "02:42:ac:16:00:02",
                "IPv4Address": "172.22.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    },
    {
        "Name": "network-C",
        "Id": "d091061f5946873946f71092afda418e89eaa9a60defc38ee7f4eaa79598b441",
        "Created": "2025-08-11T15:14:37.287568218+05:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.23.0.0/16",
                    "Gateway": "172.23.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "75c1bcdfa75e84eff98776609041952a92209a536a685a1fedd2bb49561bceae": {
                "Name": "r2-BC",
                "EndpointID": "dc196750cb6eefa4e1fabd797d71c3d51325fadafe9223c2f557a4531dd29759",
                "MacAddress": "02:42:ac:17:00:03",
                "IPv4Address": "172.23.0.3/16",
                "IPv6Address": ""
            },
            "84ad507266df9c95e81473c47ee08408fda24f68fba37c5657c7b2f3b831d744": {
                "Name": "c3-C",
                "EndpointID": "ecf5eccec81e524992f997a8a6af72734f2c23c3d88dd5b8ba9142ab353f8a36",
                "MacAddress": "02:42:ac:17:00:02",
                "IPv4Address": "172.23.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]
```

## Часть 1
```
docker run -d --name r1-AB \
  --network network-A \
  --cap-add=NET_ADMIN \
  alpine:3.22 sleep infinity

# Подключаем к сети B
docker network connect network-B r1-AB


docker run -d --name r2-BC \
  --network network-B \
  --cap-add=NET_ADMIN \
  alpine:3.22 sleep infinity

# Подключаем к сети B
docker network connect network-C r2-BC
```
<img width="809" height="130" alt="image" src="https://github.com/user-attachments/assets/7b146e0b-0c6c-47a7-bca0-373aa54484ed" />


#### пингуем контейнеры
<img width="626" height="73" alt="image" src="https://github.com/user-attachments/assets/c6bdccf8-7c0e-4ba8-97f5-4d6fdfbdf6c8" />

#### пингуем роутеры
<img width="687" height="694" alt="image" src="https://github.com/user-attachments/assets/948cc01f-6a48-46ac-b953-bab654b388d6" />


network-A
- "Subnet": "172.21.0.0/16",
- "Gateway": "172.21.0.1"

network-B 
- "Subnet": "172.22.0.0/16",
- "Gateway": "172.22.0.1"

network-C 
- "Subnet": "172.23.0.0/16",
- "Gateway": "172.23.0.1"

c1-A - 172.21.0.2

c2-B - 172.22.0.2

c3-C - 172.23.0.2

r1-AB
- 172.21.0.3/16  - A
- 172.22.0.3/16  - B

r2-BC
- 172.22.0.4/16  - B
- 172.23.0.3/16  - C

роутеры
```
docker exec -it r1-AB /bin/sh
echo 1 > /proc/sys/net/ipv4/ip_forward
ip route add 172.23.0.0/16 via 172.22.0.4



docker exec -it r2-BC /bin/sh
echo 1 > /proc/sys/net/ipv4/ip_forward
ip route add 172.21.0.0/16 via 172.22.0.3
```
<img width="736" height="385" alt="image" src="https://github.com/user-attachments/assets/7097d8c6-4845-4521-8f48-2089195f5547" />


первый контейнер - 172.21.0.2
```
docker exec -it c1-A /bin/sh
ip route add 172.22.0.0/16 via 172.21.0.3

ip route add 172.23.0.0/16 via 172.21.0.3
```
<img width="741" height="355" alt="image" src="https://github.com/user-attachments/assets/fac47d58-1c7c-4b1f-82b6-76a89344a431" />




второй контейнер - 172.22.0.2
```
docker exec -it c2-B /bin/sh
ip route add 172.21.0.0/16 via 172.22.0.3

ip route add 172.23.0.0/16 via 172.22.0.3
```
<img width="617" height="148" alt="image" src="https://github.com/user-attachments/assets/ae4fcef9-6b94-4e29-93ea-4574cc9f9b1b" />


третий контейнер - 172.23.0.2
```
docker exec -it c3-C /bin/sh
ip route add 172.21.0.0/16 via 172.23.0.3

ip route add 172.22.0.0/16 via 172.23.0.3
```
<img width="648" height="115" alt="image" src="https://github.com/user-attachments/assets/2919dd63-9547-4f9a-97a3-d8b1c094616f" />



#### пингуем c3 и c2 из c1
<img width="745" height="280" alt="image" src="https://github.com/user-attachments/assets/13e1870f-a8b8-466c-b8c2-352665c3ccab" />


#### traceroute из первого контейнера
<img width="741" height="165" alt="image" src="https://github.com/user-attachments/assets/9f72253c-62d1-460f-ab54-073c8f1bc8af" />



## Часть 2
```
docker run -d --name web1 --network network-B nginx:1.25-alpine
echo "web1" > /usr/share/nginx/html/index.html

docker run -d --name web2 --network network-B nginx:1.25-alpine
echo "web2" > /usr/share/nginx/html/index.html




docker run -d --name lb-A --network network-A --cap-add=NET_ADMIN nginx:1.25-alpine
```

docker network connect network-B lb-A

web1 - 172.22.0.5
web2 - 172.22.0.6

lb-A
- 172.21.0.4 - A

apk add curl - во все контейнеры

```
docker exec -it lb-A /bin/sh
ip route add 172.22.0.0/16 via 172.21.0.3
ip route add 172.23.0.0/16 via 172.21.0.3



cat > /etc/nginx/conf.d/loadbalancer.conf << 'EOF'
upstream backend {
    server 172.22.0.5:80;  # web1
    server 172.22.0.6:80;  # web2
}

server {
    listen 80;
    
    location / {
        proxy_pass http://backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
EOF

rm /etc/nginx/conf.d/default.conf

nginx -s reload

# настраиваем NAT на балансировщие
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
iptables -A FORWARD -i eht0 -o eth1 -j ACCEPT
iptables -A FORWARD -i eth1 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
```

#### балансировщик теперь работает как NAT и успешно балансирует трафик
<img width="680" height="74" alt="image" src="https://github.com/user-attachments/assets/eda03df9-f7f1-4610-8157-141ad16559b5" />


## Часть 3
#### текущие сети - 
<img width="555" height="175" alt="image" src="https://github.com/user-attachments/assets/d3becf4b-2dc8-4473-ae0f-a59311a3b496" />


```

docker run -d --name vpn-client \
--network network-A \
--cap-add=NET_ADMIN \
alpine:3.22 sleep infinity

docker network connect bridge vpn-client


docker run -d --name vpn-server  \
--network network-B \
--cap-add=NET_ADMIN \
alpine:3.22 sleep infinity

docker network connect bridge vpn-server 

```

--cap-add=NET_ADMIN
- Нужен для **создания и управления сетевыми интерфейсами**
- WireGuard создает виртуальный интерфейс `wg0`

<img width="972" height="763" alt="image" src="https://github.com/user-attachments/assets/b90cd60f-ecf8-4cf4-9323-4ebb9aae4e3f" />


#### сеть bridge
```
docker network inspect bridge
[
    {
        "Name": "bridge",
        "Id": "f543f09fcc340d710223cf86bc0f2318a71b1b1d8ead7e65fba60dc387f227c7",
        "Created": "2025-08-11T15:14:11.77009054+05:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "bd16a6ec1548a2f0a6ab6e28a54a49035105c4fd571e0848b726cd2b9b3d7473": {
                "Name": "vpn-client",
                "EndpointID": "853b53dc50f7931fd470e8ecafc741602b1686f3d878d512704df7219c8edcb4",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16",
                "IPv6Address": ""
            },
            "f660d071d1a6592b14bf38eebc8b0dda0667fe0e45956da08797795990aa3f51": {
                "Name": "vpn-server",
                "EndpointID": "0b63b188b5d04e63cc6ab9090df6dea83fec13b9fb9f9f1282de28f7c68dc995",
                "MacAddress": "02:42:ac:11:00:03",
                "IPv4Address": "172.17.0.3/16",
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]
```

#### едем дальше
```
docker exec -it vpn-client sh
apk update && apk add wireguard-tools

docker exec -it vpn-server sh
apk update && apk add wireguard-tools
```

```
/ # cd /tmp
/tmp # ls
/tmp # wg genkey | tee privatekey | wg pubkey > publickey
/tmp # ls
privatekey  publickey
/tmp # chmod 600 privatekey
/tmp # ll
sh: ll: not found
/tmp # ls -l
total 8
-rw-------    1 root     root            45 Aug 11 16:19 privatekey
-rw-r--r--    1 root     root            45 Aug 11 16:19 publickey
```

vpn-server 
- publickey - wICpw3Lcsav5I011qFFLMXN2BKa1/qJG1eCl8Rq25Ec=
- privatekey - KOY+7mRClKoLN0j+ufAPYyYw6mtDLoIWn2btquY/qns=

vpn-client 
- publickey - zVJAmui+NrvEfbEmNabEJhjhh5Nh6Qcj744v3wsCLDs=
- privatekey -  cFg1nlul1OCyuaWOdmVpUAam0GA31jpsRy+rxqsGykY=

#### vpn-server
```bash
cat > /etc/wireguard/wg0.conf << 'EOF'
[Interface]
Address = 10.0.0.1/24
PrivateKey = KOY+7mRClKoLN0j+ufAPYyYw6mtDLoIWn2btquY/qns= # server privatekey
ListenPort = 51820

[Peer]
PublicKey = zVJAmui+NrvEfbEmNabEJhjhh5Nh6Qcj744v3wsCLDs= # client publickey
AllowedIPs = 10.0.0.2/32
EOF
```

```bash
chmod 600 /etc/wireguard/wg0.conf
wg-quick up wg0
```

#### берем ip сервера в сети docker0
```
ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host proto kernel_lo
       valid_lft forever preferred_lft forever
2: wg0: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1420 qdisc noqueue state UNKNOWN group default qlen 1000
    link/none
    inet 10.0.0.1/24 scope global wg0
       valid_lft forever preferred_lft forever
50: eth0@if51: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:ac:16:00:07 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.22.0.7/16 brd 172.22.255.255 scope global eth0
       valid_lft forever preferred_lft forever
52: eth1@if53: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:ac:11:00:03 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.3/16 brd 172.17.255.255 scope global eth1
       valid_lft forever preferred_lft forever
```

eth1 - 172.17.0.3

и прописываем Endpoint в конфиге клиента - Endpoint = 172.17.0.3:51820

#### vpn-client
```bash
cat > /etc/wireguard/wg0.conf << 'EOF'
[Interface]
Address = 10.0.0.2/24
PrivateKey = cFg1nlul1OCyuaWOdmVpUAam0GA31jpsRy+rxqsGykY= # client privatekey
ListenPort = 51820

[Peer]
Endpoint = 172.17.0.3:51820
PublicKey = wICpw3Lcsav5I011qFFLMXN2BKa1/qJG1eCl8Rq25Ec= # server publickey
AllowedIPs = 10.0.0.0/24, 172.22.0.0/16 # сеть network-B с vpn-server
PersistentKeepalive = 25
EOF
```

```bash
chmod 600 /etc/wireguard/wg0.conf
wg-quick down wg0
wg-quick up wg0
```
#### проверяем работу на клиенте - 
- должен быть laltest handshake -- second ago
<img width="510" height="215" alt="image" src="https://github.com/user-attachments/assets/eaa5b098-af73-438f-a547-20b255b2797c" />


#### настраиваем NAT на vpn-server и запрет ICMP
- cat /proc/sys/net/ipv4/ip_forward должен быть 1 (если нет, то нужно пересоздать контейнер с флагом --cap-add=NET_ADMIN )
```
# Включаем forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

apk add iptables # в alpine нет iptables

# NAT для трафика от VPN клиентов к сети B
# смотрим на каком интерфейсе у нас network-B (172.22.0.0/16)
# указываем нужный интерфейс 
№ у меня это - eth0, тк eth1 находиться в сети bridge(docker0),
# а eth0 в сети network-B
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o eth0 -j MASQUERADE

# Разрешаем forwarding
iptables -A FORWARD -i wg0 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o wg0 -m state --state RELATED,ESTABLISHED -j ACCEPT

# Запрещаем ICMP
iptables -A INPUT -p icmp -j DROP
```


Проверяем с vpn-client - 
- не должен проходить, тк запретили ICMP
```
/tmp # ping 10.0.0.2
PING 10.0.0.2 (10.0.0.2): 56 data bytes
^C
--- 10.0.0.2 ping statistics ---
4 packets transmitted, 0 packets received, 100% packet loss
```

добавляем curl 
apk add curl

#### проверяем пинг серверов в сети vpn-server из контейнера vnp-client
web1 - 172.22.0.5
web2 - 172.22.0.6
```bash
# web1
docker exec vpn-client curl http://172.22.0.5

# web2
docker exec vpn-client curl http://172.22.0.6
```

# если работает, то пабеда
<img width="562" height="252" alt="image" src="https://github.com/user-attachments/assets/dc619ace-3cda-4905-bb62-8b43a94eb9e2" />


<img width="428" height="288" alt="image" src="https://github.com/user-attachments/assets/7c91512f-bcfd-443d-8fa2-bdffa4f4d34d" />


# итоговые ресурсы в докере - 
<img width="958" height="382" alt="image" src="https://github.com/user-attachments/assets/644849db-4246-4aed-b5a2-5e07f17a4117" />

