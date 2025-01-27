#!/bin/bash
clear
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
clear
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
echo -e "\e[32mloading...\e[0m"
clear
# Valid Script
Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
red='\e[1;31m'
green='\e[0;32m'
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[33m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
LIGHT='\033[0;37m'
grenbo="\e[92;1m"
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
# Getting
CHATID=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 3)
KEY=$(grep -E "^#bot# " "/etc/bot/.bot.db" | cut -d ' ' -f 2)
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
sensor=$(echo "$Login" | sed 's/\(.\{3\}\).*/\1xxx/')
clear
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)

export TIME="10"
IP=$(curl -sS ipv4.icanhazip.com)
ISP=$(cat /etc/xray/isp)
CITY=$(cat /etc/xray/city)
domain=$(cat /etc/xray/domain)
NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
clear
echo -e "\033[1;93m-----------------------------------------\033[0m"
echo -e " SSH Ovpn Account           "
echo -e "\033[1;93m-----------------------------------------\033[0m"
read -p " Username : " Login
read -p " Password : " Pass
read -p " Limit IP     : " iplimit
read -p " Limit Quota : " Quota
read -p " Expired (Days) : " masaaktif
#limitip
if [[ $iplimit -gt 0 ]]; then
mkdir -p /etc/limit/ssh/ip
echo -e "$iplimit" > /etc/limit/ssh/ip/$Login
else
echo > /dev/null
fi
clear
clear
tgl=$(date -d "$masaaktif days" +"%d")
bln=$(date -d "$masaaktif days" +"%b")
thn=$(date -d "$masaaktif days" +"%Y")
expe="$tgl $bln, $thn"
tgl2=$(date +"%d")
bln2=$(date +"%b")
thn2=$(date +"%Y")
tnggl="$tgl2 $bln2, $thn2"
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
expi="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
hariini=`date -d "0 days" +"%Y-%m-%d"`
expi=`date -d "$masaaktif days" +"%Y-%m-%d"`

if [ ! -e /etc/ssh ]; then
  mkdir -p /etc/ssh
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/ssh/${Login}
fi
DATADB=$(cat /etc/ssh/.ssh.db | grep "^#ssh#" | grep -w "${Login}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${Login}\b/d" /etc/ssh/.ssh.db
fi
echo "#ssh# ${Login} ${Pass} ${Quota} ${iplimit} ${expe}" >>/etc/ssh/.ssh.db
clear
mkdir -p /detail/ssh/
#Simpan Detail Akun User
cat > /detail/ssh/$Login.txt <<-END
-----------------------------------------
SSH & OpenVPN Account
-----------------------------------------
Host             : $domain
IP               : $IP
Username         : $Login
Password         : $Pass
-----------------------------------------
Limit Quota      : $Quota GB
Limit Ip         : ${iplimit} IP
Host Slowdns     : ${NS}
Pub Key          : ${PUB}
Port OpenSSH     : 443, 80, 22
Port DNS         : 443, 53, 22
Port SSH UDP     : 1-65535
Port Dropbear    : 443, 109
Port SSH WS      : 80, 8080, 8880, 2082
Port SSH SSL WS  : 443
Port SSL/TLS     : 400-900
Port OVPN WS SSL : 443
Port OVPN SSL    : 443
Port OVPN TCP    : 443, 1194
Port OVPN UDP    : 2200
BadVPN UDP       : 7100, 7300, 7300
-----------------------------------------
Payload          : GET /cdn-cgi/trace HTTP/1.1[crlf]Host: Bug_Kalian[crlf][crlf]GET-RAY / HTTP/1.1[crlf]Host: [host][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]
-----------------------------------------
-----------------------------------------
OVPN Download    : https://$domain:81/
-----------------------------------------
Save Link Account: https://$domain:81/ssh-$Login.txt
-----------------------------------------
Aktif Selama     : $masaaktif Hari
Dibuat Pada      : $tnggl
Berakhir Pada    : $expe
-----------------------------------------

END

cat > /var/www/html/ssh-$Login.txt <<-END
-----------------------------------------
Format SSH OVPN Account
-----------------------------------------
ISP              : $ISP
Location         : $CITY
Host             : $domain
Host SlowDNS     : $NS
Username         : $Login
Password         : $Pass
-----------------------------------------
Pub Key : $PUB         
Port OpenSSH     : 80, 22
Port Dropbear    : 443, 80, 109
Port Dropbear WS : 443, 80, 109
Port SSH UDP     : 1-65535
Port SSH WS      : 80, 443
Port SSH SSL WS  : 443
Port SSL/TLS     : 443, 777, 222
Port OVPN WS SSL : 443
Port OVPN SSL    : 443
Port OVPN TCP    : 1194
Port OVPN UDP    : 2200
BadVPN UDP       : 7100, 7300, 7300
-----------------------------------------
Payload Enhanced : 
GET /cdn-cgi/trace HTTP/1.1[crlf]Host: Bug_Kalian[crlf][crlf]GET-RAY / HTTP/1.1[crlf]Host: [host][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]
-----------------------------------------
Duration         : $masaaktif Hari
Expired          : $expe
-----------------------------------------

END

CHATID="$CHATID"
KEY="$KEY"
TIME="$TIME"
URL="$URL"
sensor=$(echo "$Login" | sed 's/\(.\{3\}\).*/\1xxx/')
ss="$sensor"
TEXT="
<b>-----------------------------------------</b>
<b>TRANSACTION SUCCESSFUL</b>
<b>-----------------------------------------</b>
<b>» Produk : SSH</b>
<b>» ISP :</b> <code>${ISP}</code>
<b>» Host/IP :</b> <code>${domain}</code>
<b>» Limit Quota :</b> <code>${Quota} GB</code>
<b>» Limit Login :</b> <code>${iplimit} Hp</code>
<b>» Username :</b> <code>${ss}</code>
<b>» Duration :</b> <code>${masaaktif} Days</code>
<b>-----------------------------------------</b>
<i>Automatic Notification From Server</i>
<b>-----------------------------------------</b>
"
curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null

clear
echo ""
echo -e "\033[1;93m-----------------------------------------\033[0m"
echo -e " SSH OVPN Account    "
echo -e "\033[1;93m-----------------------------------------\033[0m"
echo -e "Username         : $Login"
echo -e "Password         : $Pass"
#echo -e "Limit Quota      : $Quota GB"
echo -e "Limit Ip         : ${iplimit} User"
echo -e "Host             : $domain"
#echo -e "Host Slowdns     : ${NS}"
#echo -e "Pub Key          : ${PUB}"
echo -e "Location         : $CITY"
echo -e "ISP              : $ISP"
echo -e "Port OpenSSH     : 443, 80, 22"
#echo -e "Port DNS         : 443, 53 ,22 "
echo -e "Port SSH UDP     : 1-65535"
echo -e "Port Dropbear    : 443, 109 ,143"
echo -e "Port SSH WS      : 80,8080,8880,2086,2095"
echo -e "Port SSH SSL WS  : 443"
echo -e "Port SSL/TLS     : 443"
echo -e "Port OVPN WS SSL : 443"
echo -e "Port OVPN SSL    : 443"
echo -e "Port OVPN TCP    : 443, 1194"
echo -e "Port OVPN UDP    : 2200"
echo -e "BadVPN UDP       : 7100, 7300, 7300"
echo -e "\033[1;93m-----------------------------------------\033[0m"
echo -e " Port 80 : $domain:80@$Login:$Pass"
echo -e " Port 443 : $domain:443@$Login:$Pass"
echo -e " Udp Custom : $domain:1-65535@$Login:$Pass"
echo -e "\033[1;93m-----------------------------------------\033[0m"
echo -e "Payload      : GET / HTTP/1.1[crlf]Host: [host][crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "\033[1;93m-----------------------------------------\033[0m"
echo -e "OVPN Download    : https://$domain:81/"
echo -e "\033[1;93m-----------------------------------------\033[0m"
echo -e "Save Link Account: https://$domain:81/ssh-$Login.txt"
echo -e "\033[1;93m-----------------------------------------\033[0m"
echo -e "Aktif Selama     : $masaaktif Hari"
echo -e "Dibuat Pada      : $tnggl"
echo -e "Berakhir Pada    : $expe"
echo -e "------------------------------------------------------------"
