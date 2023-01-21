# General info

- I wanna be able to access my homelab even when i'm not at home so i'll set a VLAN server
- I'll use an ubuntu server in the homelab WAN to do so
- I'll use IPSec

# Installation

- Setting this vpn server up is pretty easy since there's a script on [](https://github.com/hwdsl2/setup-ipsec-vpn) that does everything for us
    - Download it and execute it with root permission
- The script will output our public ip address, username, pwd and PSK