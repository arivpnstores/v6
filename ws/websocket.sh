#!/bin/bash
if [ -z $1 ]; then
echo -e "?"
exit
fi
if [ $1 == "dropbear" ] >/dev/null 2>&1 ; then
/ws/ws
elif [ $1 == "openvpn" ]; then
ws 2086
fi