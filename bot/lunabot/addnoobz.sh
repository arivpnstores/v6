#!/bin/bash
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m        LUNATIC TUNNELING          \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m       CREATE IN NOOBZVPNS         \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Username  : " user
echo ""
read -p " Password  : " pass
echo ""
read -p " Expiry in : " exp
echo ""
read -p " Limit ip  : " ip

if [ ! -e /etc/cybervpn/limit/noobs/ip/ ]; then
  mkdir -p /etc/cybervpn/limit/noobs/ip/
fi
echo "$ip" > /etc/cybervpn/limit/noobs/ip/$user

noobzvpns --add-user $user $pass --expired-user $user $exp
