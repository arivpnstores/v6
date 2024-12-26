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
echo -e "\e[44;97;1m      CREATE IN VMESS XRAY         \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p "   Username         : " user
echo
read -p "   Expired (days)   : " masaaktif
echo
read -p "   Limit User (GB)  : " Quota
echo
read -p "   Limit User (ip)  : " ip


echo -e "${NC}"
  CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

  if [[ ${CLIENT_EXISTS} == '1' ]]; then
    clear
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${putih}${BGX}                     ADD VMESS ACCOUNT                      ${NC}"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
    echo -e "${putih}   A client with the specified name was already created, please choose another name. ${NC}"
    echo -e ""
    echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    exit 0
systemctl restart cybervpn
  fi
done

echo $ip > /etc/cybervpn/limit/vmess/ip/${user}

uuid=$(cat /proc/sys/kernel/random/uuid)
tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl-$bln-$thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2-$bln2-$thn2"




if [[ $user =~ ^Trial[A-Za-z0-9]+$ ]]; then
    exp=$(date -d "$masaaktif days" +"%d-%b-%Y")
    expi=$(date -d "$masaaktif hour" +"%H:%M:%S")
    echo "### $user $expi" >> /etc/trialxray.txt
else
    exp=$(date -d "$masaaktif days" +"%d-%b-%Y")
fi


sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json


sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json


VMESS_WS=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
VMESS_NON_TLS=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF`
VMESS_GRPC=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
cat >/home/vps/public_html/vmess-$user.yaml <<-END


# Format Vmess WS TLS

- name: Vmess-$user-WS TLS
  type: vmess
  server: ${domain}
  port: 443
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}

# Format Vmess WS Non TLS

- name: Vmess-$user-WS Non TLS
  type: vmess
  server: ${domain}
  port: 80
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}

# Format Vmess gRPC

- name: Vmess-$user-gRPC (SNI)
  server: ${domain}
  port: 443
  type: vmess
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  network: grpc
  tls: true
  servername: ${domain}
  skip-cert-verify: true
  grpc-opts:
    grpc-service-name: vmess-grpc


END
_______________________________________________________
              Link Vmess Account
_______________________________________________________
Link TLS : vmess://$(echo $VMESS_WS | base64 -w 0)
_______________________________________________________
Link none TLS : vmess://$(echo $VMESS_NON_TLS | base64 -w 0)
_______________________________________________________
Link GRPC : vmess://$(echo $VMESS_GRPC | base64 -w 0)
_______________________________________________________




vmesslink1="vmess://$(echo $VMESS_WS | base64 -w 0)"
vmesslink2="vmess://$(echo $VMESS_NON_TLS | base64 -w 0)"
vmesslink3="vmess://$(echo $VMESS_GRPC | base64 -w 0)"

systemctl restart xray
systemctl restart nginx

service cron restart
echo "$user $exp $max $uuid" >> /root/limit/limitvmess.txt
if [ ! -e /etc/vmess ]; then
  mkdir -p /etc/vmess
fi

if [ -z ${iplim} ]; then
  iplim="0"
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))
if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/vmess/${user}
fi

DATADB=$(cat /etc/vmess/.vmess.db | grep "^#vm#" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/vmess/.vmess.db
fi
status="UNLOCKED"
echo "### ${user} ${expe} ${status} ${uuid} ${Quota}" >>/etc/vmess/.vmess.db

echo "### ${user} ${exp}" >>/etc/rizkihdyt/ws

clear
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${putih}${BGX}                SUCCESS CREATE  VMESS                 ${NC}"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Remarks      : ${user}"
echo -e "Domain       : ${domain}"
echo -e "Host Slowdns : ${NS}"
echo -e "Pub Key      : ${PUB}"
echo -e "Location     : $CITY"
echo -e "User Quota   : ${Quota} GB"
echo -e "Port TLS     : 443"
echo -e "Port NTLS    : 80, 8080, 2086"
echo -e "Port DNS     : 443, 53 "
echo -e "Port GRPC    : 443"
echo -e "User ID      : ${uuid}"
echo -e "AlterId      : 0"
echo -e "Security     : auto"
echo -e "Network      : WS or gRPC"
echo -e "Path TLS     : /vmess - /multipath"
echo -e "Path Dynamic : CF-XRAY:http://bug.com "
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "                      LINK WS TLS"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "     ${vmesslink1}"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "                    LINK WS NONE TLS"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "     ${vmesslink2}"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "                        LINK GRPC"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "     ${vmesslink3}"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "                    FORMAT OPENCLASH"
echo -e "${blue}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "     https://${domain}:81/vmess-$user.txt"
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
