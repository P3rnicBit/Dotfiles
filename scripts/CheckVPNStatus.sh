#!/bin/bash
# if ps aux | grep -q "[o]penvpn --config";then
# echo "✓ VPN"
# else
# echo "✗ VPN"
# fi
#ps aux  returns the running processes
#grep -q  = checks for the same processes as in " "
#[o]penvpn --config - tells it to check for any openvpn config. 
#the [o] means that grep shouldn't check itself (just the first letter, doesn't have to be o)

if protonvpn status | grep -q "Status: Connected"; then
echo "✓ VPN"
else
    echo "✗ VPN"
fi