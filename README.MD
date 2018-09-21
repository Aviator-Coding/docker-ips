# IPSUM - Wallet
## Dockercontainer for IPSUM Wallet

Run Container:
>```docker run --name ips-masternode-01 --restart=always -d --net mn_net -p xxx.xxx.xxx.xxx:1947:1947 -p xxx.xxx.xxx.xx:1948:1948  -v /masternode/ips_01/.ips:/root/.ips aviator86/goa-docker```

> /masternode/ips_01/.ips - is the location where you store your config on the host  
--name  ips-masternode-01 - is the tag which will show up in the Container list name it whatever you want

Stoping Container:
>```docker stop ips-masternode-01```

Restart Container:
>```docker restart ips-masternode-01```

Start Container:
>```docker start ips-masternode-01```

Delete Container: Need to stop Container First
>```docker rm ips-masternode-01```

See Container Logs:
>```docker logs ips-masternode-01```

## Wallet Status inside Container
See ips Chain Status:
>```docker exec -it ips-masternode-01 ips-cli getinfo```

See ips Chain Masternode Status:
>```docker exec -it ips-masternode-01 ips-cli masternode status```