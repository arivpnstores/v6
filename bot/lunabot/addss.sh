#!/bin/bash
RED='\033[0;31m'
NC='\e[0m'
gray="\e[1;30m"
blue="\e[1;96m"
putih="\e[1;97m"
putih1="\e[97m"
green='\033[0;32m'
grenbo="\033[1;95m"
YELL='\033[1;33m'
BGX="\e[104m"
clear
domain=$(cat /etc/xray/domain)
PUB=$(cat /etc/slowdns/server.pub)
clear
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
  clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m        LUNATIC TUNNELING          \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m       CREATE IN NOOBZVPNS         \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p "   Username      : " user
echo -e ""
read -p "   Expiry in     : " masaaktif


echo -e "${NC}"
  CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

  if [[ ${CLIENT_EXISTS} == '1' ]]; then
    clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m        LUNATIC TUNNELING          \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;91;1m          NAME IS READY            \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
    exit 0
systemctl restart cybervpn
  fi
done

cipher="aes-128-gcm"
uuid=$(cat /proc/sys/kernel/random/uuid)
tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"

if [[ $user =~ ^Trial[A-Za-z0-9]+$ ]]; then
    exp=$(date -d "$masaaktif days" +"%d-%b-%Y")
    expi=$(date -d "$masaaktif hour" +"%H:%M:%S")
    echo "### $user $expi" >> /etc/trialxray.txt
else
    exp=$(date -d "$masaaktif days" +"%d-%b-%Y")
fi

if [ ! -e /etc/shadowsocks/ ]; then
  mkdir -p /etc/shadowsocks/
fi


sed -i '/#ssws$/a\## '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#ssgrpc$/a\## '"$user $exp"'\
},{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json

echo "## $user $exp $uuid" >> /etc/shadowsocks/.shadowsocks.db

echo $cipher:$uuid >/tmp/log
shadowsocks_base64=$(cat /tmp/log)
echo -n "${shadowsocks_base64}" | base64 >/tmp/log1
shadowsocks_base64e=$(cat /tmp/log1)

shadowsockslink="ss://${shadowsocks_base64e}@${domain}:443?path=/ss-ws&security=tls&encryption=none&type=ws#${user}"

shadowsockslink1="ss://${shadowsocks_base64e}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=ss-grpc&sni=bug.com#${user}"
systemctl restart xray

clear
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${putih}${BGX}                SUCCESS CREATE  VMESS                 ${NC}"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Remarks        : ${user}"
echo -e "Domain         : ${domain}"
echo -e "Location       : $CITY"
echo -e "User Quota     : ${Quota} GB"
echo -e "User ID        : ${uuid}"
echo -e "Port TLS       : 443"
echo -e "Port  GRPC     : 443"
echo -e "Cipers         : aes-128-gcm"
echo -e "Network        : ws or grpc"
echo -e "Path           : /ss-ws or /ss-grpc"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "                      LINK WS TLS"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${shadowsockslink}"

echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "                        LINK GRPC"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${shadowsockslink1}"

echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Aktif Selama   : $masaaktif Hari"
echo -e "Dibuat Pada    : $tnggl"
echo -e "Berakhir Pada  : $expe"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
#echo -e "${putih}"
#read -n 1 -s -r -p "   Press [ Enter ] to back menu vmess"
#echo -e "${NC}"
#vmess

#systemctl restart delproject
