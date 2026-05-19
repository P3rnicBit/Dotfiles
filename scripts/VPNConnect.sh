#!/bin/bash
# VPNConnect - A script to connect to a VPN using OpenVPN

# cd ~/VPNs
# sudo openvpn --config pl-free-9.protonvpn.udp.ovpn --auth-user-pass  Auth.txt

#--config pl-free-9.protonvpn.udp.ovpn = the used server
#--auth-user-pass  Auth.txt = uses a .txt file for authentication. | NO LONGER THERE
# recommended to make sure only YOU can use, read and any other things
#also set openvpn to have access to root, will need pswd if you don't
#and you can't input the pswd if you don't have an input so it just won't work

#NEW WAY, PROTON VPN CLI

if protonvpn status | grep -q "Status: Connected"; then
       protonvpn disconnect
else
        protonvpn connect --country "Finland"
fi
