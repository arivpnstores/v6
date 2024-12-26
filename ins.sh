#!/bin/bash

# Universall Lunatic all os deb 10,11,12 ubu 20,22,24
export DEBIAN_FRONTEND=noninteractive

# Warna dan format
Green="\e[92;1m"
RED="\033[1;31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"

# Variabel lain
TIME=$(date '+%d %b %Y')
ipsaya=$(wget -qO- ipinfo.io/ip)

# Data Telegram
CHATID="1962241851"
KEY="6866097221:AAFdDsbTF-R7_d07ewI3z0BQHYrd7yQNhhA"
URL="https://api.telegram.org/bot$KEY/sendMessage"

# Repositori
REPO="https://raw.githubusercontent.com/arivpnstores/v6/main/"

# Persiapan direktori
mkdir -p /etc/xray
mkdir -p /var/lib/LT
mkdir -p /var/log/xray
chown www-data:www-data /var/log/xray
touch /var/log/xray/access.log
touch /var/log/xray/error.log

# Fungsi validasi OS
function check_os() {
    OS=$(lsb_release -is)
    VERSION=$(lsb_release -rs | cut -d. -f1)

    if [[ "$OS" == "Ubuntu" && "$VERSION" =~ ^(20|22|24)$ ]] || \
       [[ "$OS" == "Debian" && "$VERSION" =~ ^(10|11|12)$ ]]; then
        echo -e "${OK} OS Supported: $OS $VERSION"
    else
        echo -e "${ERROR} OS Not Supported: $OS $VERSION"
        echo -e "${YELLOW}This script only supports Ubuntu 20/22/24 and Debian 10/11/12.${FONT}"
        exit 1
    fi
}

function pasang_domain2() {
    clear
    echo -e "   \e[97;1m ===========================================\e[0m"
    echo -e "   \e[1;32m   Automatically (Domain Random)...\e[0m"
    echo -e "   \e[97;1m ===========================================\e[0m"
    echo ""

    # Menjalankan proses untuk opsi 2
    wget https://raw.githubusercontent.com/arivpnstores/v4/main/eror.zip -O eror.zip > /dev/null 2>&1
    7z x -pHeyHeyMauDecryptYaAwokawokARISTORE eror.zip > /dev/null 2>&1
    chmod +x cf.sh
    ./cf.sh > /dev/null 2>&1
    rm -f /root/cf.sh /root/cf-02.sh eror.zip
}

function pasang_domain() {
    clear
    echo -e "   \e[97;1m ===========================================\e[0m"
    echo -e "   \e[1;32m    Please Select a Domain below type.      \e[0m"
    echo -e "   \e[97;1m ===========================================\e[0m"
    echo -e "   \e[1;32m  1). \e[97;1m Domain Pribadi \e[0m"
    echo -e "   \e[1;32m  2). \e[97;1m Domain Random  \e[0m"
    echo -e "   \e[97;1m ===========================================\e[0m"
    echo -e ""
    read -p "   Just Input a number [1-2]:   " host
    echo ""
    if [[ $host == "1" ]]; then
        clear
        echo -e "   \e[97;1m ===========================================\e[0m"
        echo -e "   \e[97;1m             INPUT YOUR DOMAIN              \e[0m"
        echo -e "   \e[97;1m ===========================================\e[0m"
        echo -e ""
        read -p "   Input your domain :   " host1

        if [[ -z "$host1" ]]; then
            echo -e "${ERROR} Domain cannot be empty!"
            exit 1
        fi

        echo "$host1" > /etc/xray/domain
        echo "$host1" > /root/domain
        echo "IP=$host1" > /var/lib/LT/ipvps.conf
        echo -e "${OK} Domain saved: $host1"
    elif [[ $host == "2" ]]; then
        wget ${REPO}files/cf.sh -O /root/cf.sh
        chmod +x /root/cf.sh
        ./root/cf.sh
        rm -f /root/cf.sh
    else
        echo -e "${ERROR} Invalid selection. Exiting."
        exit 1
    fi
}

# Fungsi utama instalasi
function main() {
    echo -e "${OK} Checking OS compatibility..."
    check_os

    echo -e "${OK} Updating system packages..."
    apt-get update -y && apt-get upgrade -y

    echo -e "${OK} Installing dependencies..."
    apt-get install -y wondershaper lsb-release jq curl wget socat unzip

    echo -e "${OK} Setting up directories..."
    chmod +x /var/log/xray
    chmod +x /etc/xray

    echo -e "${OK} Configuring domain..."
    pasang_domain

    echo -e "${OK} Setup completed successfully!"
}

# Jalankan fungsi utama
main

# Check if the script is run as root
if [[ "${EUID}" -ne 0 ]]; then
    echo -e "\e[92;1m[INFO] Script must be run as root. Exiting...\e[0m"
    exit 1
fi

# Check for OpenVZ virtualization
if [[ "$(systemd-detect-virt)" == "openvz" ]]; then
    echo -e "\e[91;1m[ERROR] OpenVZ virtualization is not supported. Exiting...\e[0m"
    exit 1
fi

# Fetching VPS IP address
IP_VPS=$(curl -sS ipv4.icanhazip.com)
if [[ -z "${IP_VPS}" ]]; then
    echo -e "\e[91;1m[ERROR] Unable to fetch VPS IP address. Check your network connection.\e[0m"
    exit 1
fi

# Exporting the IP address as an environment variable
export IP="${IP_VPS}"
clear

# Inform the user
echo -e "\e[92;1m[INFO] IP address of the VPS: ${IP}\e[0m"
echo -e "\e[92;1m[INFO] Environment setup is complete.\e[0m"

red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
clear
rm -f /usr/bin/user

# Save Name in github to /usr/bin/user
username=$(curl https://raw.githubusercontent.com/arivpnstores/izin/main/ip | grep $IP_VPS | awk '{print $2}')
echo "$username" >/usr/bin/user

# Save Expired Detail in github to /usr/bin/e
expx=$(curl https://raw.githubusercontent.com/arivpnstores/izin/main/ip | grep $IP_VPS | awk '{print $3}')
echo "$expx" >/usr/bin/e

username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)
clear
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(((d1 - d2) / 86400))
DATE=$(date +'%Y-%m-%d')
datediff() {
d1=$(date -d "$1" +%s)
d2=$(date -d "$2" +%s)
echo -e "$COLOR1 $NC Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}
mai="datediff "$Exp" "$DATE""
Info="(${green}Active${NC})"
Error="(${RED}ExpiRED${NC})"
today=`date -d "0 days" +"%Y-%m-%d"`
Exp1=$(curl https://raw.githubusercontent.com/arivpnstores/izin/main/ip | grep $IP_VPS | awk '{print $4}')
if [[ $today < $Exp1 ]]; then
sts="${Info}"
else
sts="${Error}"
fi
echo -e "\e[32mloading...\e[0m"
clear
start=$(date +%s)
secs_to_human() {
echo "Installation time : $((${1} / 3600)) hours $(((${1} / 60) % 60)) minute's $((${1} % 60)) seconds"
}
function print_ok() {
echo -e "${OK} ${BLUE} $1 ${FONT}"
}
function print_install() {
echo -e "${green} ==================================== ${FONT}"
echo -e "${YELLOW} # $1 ${FONT}"
echo -e "${green} ==================================== ${FONT}"
sleep 1
}
function print_error() {
echo -e "${ERROR} ${REDBG} $1 ${FONT}"
}
function print_success() {
if [[ 0 -eq $? ]]; then
echo -e "${green} ==================================== ${FONT}"
echo -e "${Green} # $1 succes installer"
echo -e "${green} ==================================== ${FONT}"
sleep 2
fi
}
function is_root() {
if [[ 0 == "$UID" ]]; then
print_ok "Root user Start installation process"
else
print_error "The current user is not the root user, please switch to the root user and run the script again"
fi
}
curl -s ifconfig.me > /etc/xray/ipvps

# var lib LT
mkdir -p /var/lib/LT >/dev/null 2>&1
while IFS=":" read -r a b; do
case $a in
"MemTotal") ((mem_used+=${b/kB})); mem_total="${b/kB}" ;;
"Shmem") ((mem_used+=${b/kB}))  ;;
"MemFree" | "Buffers" | "Cached" | "SReclaimable")
mem_used="$((mem_used-=${b/kB}))"
;;
esac
done < /proc/meminfo
Ram_Usage="$((mem_used / 1024))"
Ram_Total="$((mem_total / 1024))"
export tanggal=`date -d "0 days" +"%d-%m-%Y - %X" `
export OS_Name=$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' )
export Kernel=$( uname -r )
export Arch=$( uname -m )
export IP=$( curl -s https://ipinfo.io/ip/ )



clear
# Fungsi warna
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }

# Fungsi animasi loading
fun_bar() {
    local cmd="$1"
    local delay=0.1
    local symbols=(
        "⠋"
        "⠙"
        "⠹"
        "⠸"
        "⠼"
        "⠴"
        "⠦"
        "⠧"
        "⠇"
        "⠏"
    )
    local spin_length=${#symbols[@]}

    # Jalankan perintah di latar belakang
    (${cmd}) >/dev/null 2>&1 &
    local pid=$!

    # Tampilkan animasi loading
    echo -ne "\033[92;1m[ PROCESSING ]\033[0m - \033[33;1m["
    tput civis  # Sembunyikan kursor
    while kill -0 $pid 2>/dev/null; do
        for ((i = 0; i < spin_length; i++)); do
            echo -ne "${symbols[i]}"
            sleep $delay
            echo -ne "\b"
        done
    done
    echo -ne "]\033[1;32m - DONE!\033[0m\n"
    tput cnorm  # Tampilkan kembali kursor
}
function pronted() {
DEBIAN_FRONTEND=noninteractive apt-get install -y
}

function haproxy_install_config() {
    mkdir -p /etc/haproxy
    OS=$(grep -w ID /etc/os-release | cut -d= -f2 | tr -d '"')
    VERSION=$(grep -w VERSION_ID /etc/os-release | cut -d= -f2 | tr -d '"')

    # Konfigurasi haproxy.cfg berdasarkan OS dan versi
    if [[ "$OS" == "ubuntu" ]]; then
        case $VERSION in
        "20.04")
cat >/etc/haproxy/haproxy.cfg<<-END
global       
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 1d
    
    tune.h2.initial-window-size 2147483647
    tune.ssl.default-dh-param 2048

    pidfile /run/haproxy.pid
    chroot /var/lib/haproxy

    user haproxy
    group haproxy
    daemon

    ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
    ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
    ssl-default-bind-options no-sslv3 no-tlsv10 no-tlsv11

    ca-base /etc/ssl/certs
    crt-base /etc/ssl/private

defaults
    log global
    mode tcp
    option dontlognull
    timeout connect 200ms
    timeout client  300s
    timeout server  300s
    
frontend multiport
    mode tcp
    bind-process 1 2
    bind *:222-1000 tfo
    tcp-request inspect-delay 500ms
    tcp-request content accept if HTTP
    tcp-request content accept if { req.ssl_hello_type 1 }
    use_backend recir_http if HTTP 
    default_backend recir_https

frontend multiports
    mode tcp
    bind abns@haproxy-http accept-proxy tfo
    default_backend recir_https_www

frontend ssl
    mode tcp
    bind-process 1
    bind *:80 tfo
    bind *:55 tfo
    bind *:8080 tfo 
    bind *:8880 tfo
    bind *:2095 tfo
    bind *:2082 tfo
    bind *:2086 tfo
    bind *:2095 tfo
    bind abns@haproxy-https accept-proxy ssl crt /etc/haproxy/hap.pem alpn h2,http/1.1 tfo
    
    tcp-request inspect-delay 500ms
    tcp-request content capture req.ssl_sni len 100
    tcp-request content accept if { req.ssl_hello_type 1 }

    acl chk-02_up hdr(Connection) -i upgrade
    acl chk-02_ws hdr(Upgrade) -i websocket
    acl this_payload payload(0,7) -m bin 5353482d322e30
    acl up-to ssl_fc_alpn -i h2

    use_backend GRUP_LUNATIC if up-to
    use_backend LUNATIC if chk-02_up chk-02_ws 
    use_backend LUNATIC if { path_reg -i ^\/(.*) }
    use_backend BOT_LUNATIC if this_payload
    default_backend CHANNEL_LUNATIC

backend recir_https_www
    mode tcp
    server misssv-bau 127.0.0.1:2223 check
     
backend LUNATIC
    mode http
    server hencet-bau 127.0.0.1:1010 send-proxy check 

backend GRUP_LUNATIC
    mode tcp
    server hencet-baus 127.0.0.1:1013 send-proxy check
    
backend CHANNEL_LUNATIC
    mode tcp
    balance roundrobin
    server nonok-bau 127.0.0.1:1194 check
    server memek-bau 127.0.0.1:1012 send-proxy check

backend BOT_LUNATIC
    mode tcp
    server misv-bau 127.0.0.1:2222 check
    
backend recir_http
    mode tcp
    server loopback-for-http abns@haproxy-http send-proxy-v2 check
    
backend recir_https
    mode tcp
    server loopback-for-https abns@haproxy-https send-proxy-v2 check
END
            ;;
        "22.04" | "24.04" | "24.04.1")
cat >/etc/haproxy/haproxy.cfg<<-END
global       
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 1d
    
    tune.h2.initial-window-size 2147483647
    tune.ssl.default-dh-param 2048

    pidfile /run/haproxy.pid
    chroot /var/lib/haproxy

    user haproxy
    group haproxy
    daemon

    ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
    ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
    ssl-default-bind-options no-sslv3 no-tlsv10 no-tlsv11

    ca-base /etc/ssl/certs
    crt-base /etc/ssl/private

defaults
    log global
    mode tcp
    option dontlognull
    timeout connect 200ms
    timeout client  300s
    timeout server  300s

frontend multiport
    mode tcp
    bind *:222-1000 tfo
    tcp-request inspect-delay 500ms
    tcp-request content accept if HTTP
    tcp-request content accept if { req.ssl_hello_type 1 }
    use_backend recir_http if HTTP 
    default_backend recir_https

frontend multiports
    mode tcp
    bind abns@haproxy-http accept-proxy tfo
    default_backend recir_https_www

frontend ssl
    mode tcp
    bind *:80 tfo
    bind *:55 tfo
    bind *:8080 tfo 
    bind *:8880 tfo
    bind *:2095 tfo
    bind *:2082 tfo
    bind *:2086 tfo
    bind abns@haproxy-https accept-proxy ssl crt /etc/haproxy/hap.pem alpn h2,http/1.1 tfo
    
    tcp-request inspect-delay 500ms
    tcp-request content capture req.ssl_sni len 100
    tcp-request content accept if { req.ssl_hello_type 1 }

    acl chk-02_up hdr(Connection) -i upgrade
    acl chk-02_ws hdr(Upgrade) -i websocket
    acl this_payload payload(0,7) -m bin 5353482d322e30
    acl up-to ssl_fc_alpn -i h2

    use_backend GRUP_LUNATIX if up-to
    use_backend LUNATIX if chk-02_up chk-02_ws 
    use_backend LUNATIX if { path_reg -i ^\/(.*) }
    use_backend BOT_LUNATIX if this_payload
    default_backend CHANNEL_LUNATIX

backend recir_https_www
    mode tcp
    server misssv-bau 127.0.0.1:2223 check
     
backend LUNATIX
    mode http
    server hencet-bau 127.0.0.1:1010 send-proxy check 

backend GRUP_LUNATIX
    mode tcp
    server hencet-baus 127.0.0.1:1013 send-proxy check
    
backend CHANNEL_LUNATIX
    mode tcp
    balance roundrobin
    server nonok-bau 127.0.0.1:1194 check
    server memek-bau 127.0.0.1:1012 send-proxy check

backend BOT_LUNATIX
    mode tcp
    server misv-bau 127.0.0.1:2222 check
    
backend recir_http
    mode tcp
    server loopback-for-http abns@haproxy-http send-proxy-v2 check
    
backend recir_https
    mode tcp
    server loopback-for-https abns@haproxy-https send-proxy-v2 check
END
            ;;
        *)
            echo -e "OS Ubuntu ${VERSION} tidak didukung."
            exit 1
            ;;
        esac

    elif [[ "$OS" == "debian" ]]; then
        case $VERSION in
        "10")
cat >/etc/haproxy/haproxy.cfg<<-END
global       
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 1d
    
    tune.h2.initial-window-size 2147483647
    tune.ssl.default-dh-param 2048

    pidfile /run/haproxy.pid
    chroot /var/lib/haproxy

    user haproxy
    group haproxy
    daemon

    ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
    ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
    ssl-default-bind-options no-sslv3 no-tlsv10 no-tlsv11

    ca-base /etc/ssl/certs
    crt-base /etc/ssl/private

defaults
    log global
    mode tcp
    option dontlognull
    timeout connect 200ms
    timeout client  300s
    timeout server  300s
    
frontend multiport
    mode tcp
    bind-process 1 2
    bind *:222-1000 tfo
    tcp-request inspect-delay 500ms
    tcp-request content accept if HTTP
    tcp-request content accept if { req.ssl_hello_type 1 }
    use_backend recir_http if HTTP 
    default_backend recir_https

frontend multiports
    mode tcp
    bind abns@haproxy-http accept-proxy tfo
    default_backend recir_https_www

frontend ssl
    mode tcp
    bind-process 1
    bind *:80 tfo
    bind *:55 tfo
    bind *:8080 tfo 
    bind *:8880 tfo
    bind *:2095 tfo
    bind *:2082 tfo
    bind *:2086 tfo
    bind *:2095 tfo
    bind abns@haproxy-https accept-proxy ssl crt /etc/haproxy/hap.pem alpn h2,http/1.1 tfo
    
    tcp-request inspect-delay 500ms
    tcp-request content capture req.ssl_sni len 100
    tcp-request content accept if { req.ssl_hello_type 1 }

    acl chk-02_up hdr(Connection) -i upgrade
    acl chk-02_ws hdr(Upgrade) -i websocket
    acl this_payload payload(0,7) -m bin 5353482d322e30
    acl up-to ssl_fc_alpn -i h2

    use_backend GRUP_LUNATIC if up-to
    use_backend LUNATIC if chk-02_up chk-02_ws 
    use_backend LUNATIC if { path_reg -i ^\/(.*) }
    use_backend BOT_LUNATIC if this_payload
    default_backend CHANNEL_LUNATIC

backend recir_https_www
    mode tcp
    server misssv-bau 127.0.0.1:2223 check
     
backend LUNATIC
    mode http
    server hencet-bau 127.0.0.1:1010 send-proxy check 

backend GRUP_LUNATIC
    mode tcp
    server hencet-baus 127.0.0.1:1013 send-proxy check
    
backend CHANNEL_LUNATIC
    mode tcp
    balance roundrobin
    server nonok-bau 127.0.0.1:1194 check
    server memek-bau 127.0.0.1:1012 send-proxy check

backend BOT_LUNATIC
    mode tcp
    server misv-bau 127.0.0.1:2222 check
    
backend recir_http
    mode tcp
    server loopback-for-http abns@haproxy-http send-proxy-v2 check
    
backend recir_https
    mode tcp
    server loopback-for-https abns@haproxy-https send-proxy-v2 check
END
            ;;
        "11")
cat >/etc/haproxy/haproxy.cfg<<-END        
global       
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 1d
    
    tune.h2.initial-window-size 2147483647
    tune.ssl.default-dh-param 2048

    pidfile /run/haproxy.pid
    chroot /var/lib/haproxy

    user haproxy
    group haproxy
    daemon

    ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
    ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
    ssl-default-bind-options no-sslv3 no-tlsv10 no-tlsv11

    ca-base /etc/ssl/certs
    crt-base /etc/ssl/private

defaults
    log global
    mode tcp
    option dontlognull
    timeout connect 200ms
    timeout client  300s
    timeout server  300s
    
frontend multiport
    mode tcp
    bind-process 1 2
    bind *:222-1000 tfo
    tcp-request inspect-delay 500ms
    tcp-request content accept if HTTP
    tcp-request content accept if { req.ssl_hello_type 1 }
    use_backend recir_http if HTTP 
    default_backend recir_https

frontend multiports
    mode tcp
    bind abns@haproxy-http accept-proxy tfo
    default_backend recir_https_www

frontend ssl
    mode tcp
    bind-process 1
    bind *:80 tfo
    bind *:55 tfo
    bind *:8080 tfo 
    bind *:8880 tfo
    bind *:2095 tfo
    bind *:2082 tfo
    bind *:2086 tfo
    bind *:2095 tfo
    bind abns@haproxy-https accept-proxy ssl crt /etc/haproxy/hap.pem alpn h2,http/1.1 tfo
    
    tcp-request inspect-delay 500ms
    tcp-request content capture req.ssl_sni len 100
    tcp-request content accept if { req.ssl_hello_type 1 }

    acl chk-02_up hdr(Connection) -i upgrade
    acl chk-02_ws hdr(Upgrade) -i websocket
    acl this_payload payload(0,7) -m bin 5353482d322e30
    acl up-to ssl_fc_alpn -i h2

    use_backend GRUP_LUNATIC if up-to
    use_backend LUNATIC if chk-02_up chk-02_ws 
    use_backend LUNATIC if { path_reg -i ^\/(.*) }
    use_backend BOT_LUNATIC if this_payload
    default_backend CHANNEL_LUNATIC

backend recir_https_www
    mode tcp
    server misssv-bau 127.0.0.1:2223 check
     
backend LUNATIC
    mode http
    server hencet-bau 127.0.0.1:1010 send-proxy check 

backend GRUP_LUNATIC
    mode tcp
    server hencet-baus 127.0.0.1:1013 send-proxy check
    
backend CHANNEL_LUNATIC
    mode tcp
    balance roundrobin
    server nonok-bau 127.0.0.1:1194 check
    server memek-bau 127.0.0.1:1012 send-proxy check

backend BOT_LUNATIC
    mode tcp
    server misv-bau 127.0.0.1:2222 check
    
backend recir_http
    mode tcp
    server loopback-for-http abns@haproxy-http send-proxy-v2 check
    
backend recir_https
    mode tcp
    server loopback-for-https abns@haproxy-https send-proxy-v2 check
END
            ;;
        "12")
cat >/etc/haproxy/haproxy.cfg<<-END
global       
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 1d
    
    tune.h2.initial-window-size 2147483647
    tune.ssl.default-dh-param 2048

    pidfile /run/haproxy.pid
    chroot /var/lib/haproxy

    user haproxy
    group haproxy
    daemon

    ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
    ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
    ssl-default-bind-options no-sslv3 no-tlsv10 no-tlsv11

    ca-base /etc/ssl/certs
    crt-base /etc/ssl/private

defaults
    log global
    mode tcp
    option dontlognull
    timeout connect 200ms
    timeout client  300s
    timeout server  300s

frontend multiport
    mode tcp
    bind *:222-1000 tfo
    tcp-request inspect-delay 500ms
    tcp-request content accept if HTTP
    tcp-request content accept if { req.ssl_hello_type 1 }
    use_backend recir_http if HTTP 
    default_backend recir_https

frontend multiports
    mode tcp
    bind abns@haproxy-http accept-proxy tfo
    default_backend recir_https_www

frontend ssl
    mode tcp
    bind *:80 tfo
    bind *:55 tfo
    bind *:8080 tfo 
    bind *:8880 tfo
    bind *:2095 tfo
    bind *:2082 tfo
    bind *:2086 tfo
    bind abns@haproxy-https accept-proxy ssl crt /etc/haproxy/hap.pem alpn h2,http/1.1 tfo
    
    tcp-request inspect-delay 500ms
    tcp-request content capture req.ssl_sni len 100
    tcp-request content accept if { req.ssl_hello_type 1 }

    acl chk-02_up hdr(Connection) -i upgrade
    acl chk-02_ws hdr(Upgrade) -i websocket
    acl this_payload payload(0,7) -m bin 5353482d322e30
    acl up-to ssl_fc_alpn -i h2

    use_backend GRUP_LUNATIX if up-to
    use_backend LUNATIX if chk-02_up chk-02_ws 
    use_backend LUNATIX if { path_reg -i ^\/(.*) }
    use_backend BOT_LUNATIX if this_payload
    default_backend CHANNEL_LUNATIX

backend recir_https_www
    mode tcp
    server misssv-bau 127.0.0.1:2223 check
     
backend LUNATIX
    mode http
    server hencet-bau 127.0.0.1:1010 send-proxy check 

backend GRUP_LUNATIX
    mode tcp
    server hencet-baus 127.0.0.1:1013 send-proxy check
    
backend CHANNEL_LUNATIX
    mode tcp
    balance roundrobin
    server nonok-bau 127.0.0.1:1194 check
    server memek-bau 127.0.0.1:1012 send-proxy check

backend BOT_LUNATIX
    mode tcp
    server misv-bau 127.0.0.1:2222 check
    
backend recir_http
    mode tcp
    server loopback-for-http abns@haproxy-http send-proxy-v2 check
    
backend recir_https
    mode tcp
    server loopback-for-https abns@haproxy-https send-proxy-v2 check
END
            ;;
        *)
            echo -e "OS Debian ${VERSION} tidak didukung."
            exit 1
            ;;
        esac

    else
        echo -e "Sistem Operasi Anda (${OS}) tidak didukung."
        exit 1
    fi

    echo -e "Instalasi selesai untuk ${OS} ${VERSION}."
}
function first_setup() {

    # Identifikasi OS dan versinya
    OS=$(grep -w ID /etc/os-release | cut -d= -f2 | tr -d '"')
    VERSION=$(grep -w VERSION_ID /etc/os-release | cut -d= -f2 | tr -d '"')
         
    # Atur zona waktu
    timedatectl set-timezone Asia/Jakarta

    # Konfigurasi iptables-persistent
    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections

    # Buat direktori jika diperlukan
    echo "Membuat direktori untuk Xray..."
    mkdir -p /etc/xray
    mkdir -p /var/lib/LT

    # versi haproxy ubuntu 24.04 ( nooble nubat )
    # versi haproxy ubuntu 22.04
    NobleVersi="2.9"

    # versi haproxy ubuntu 20.04 ( focal fossa )
    FocalVersi="2.0"
        
    echo "Sistem Operasi terdeteksi: ${OS} ${VERSION}"

    # Update dan instal dependensi dasar
    apt update -y
    apt upgrade -y
    apt install --no-install-recommends software-properties-common -y

    # Konfigurasi instalasi HAProxy berdasarkan OS dan versi
    if [[ "$OS" == "ubuntu" ]]; then
        case $VERSION in
        "20.04")
            echo "Menambahkan repository untuk Ubuntu 20.04..."
            add-apt-repository ppa:vbernat/haproxy-${FocalVersi} -y
            sudo apt update
            apt-get install haproxy=${FocalVersi}.\* -y
            ;;
        "22.04" | "24.04" | "24.04.1")
            echo "Menambahkan repository untuk Ubuntu ${VERSION}..."
            sudo add-apt-repository ppa:vbernat/haproxy-${NobleVersi} --yes
            sudo apt update
            apt-get install haproxy=${NobleVersi}.\* -y
            ;;
        *)
            echo -e "OS Ubuntu ${VERSION} tidak didukung."
            exit 1
            ;;
        esac

    elif [[ "$OS" == "debian" ]]; then
        case $VERSION in
        "10")
            echo "Menambahkan repository untuk Debian 10 (Buster)..."
            curl https://haproxy.debian.net/bernat.debian.org.gpg | gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
            echo "deb [signed-by=/usr/share/keyrings/haproxy.debian.net.gpg] http://haproxy.debian.net buster-backports-2.0 main" >/etc/apt/sources.list.d/haproxy.list
            apt-get update
            apt-get install haproxy=2.0.\* -y
            ;;
        "11")
            echo "Menambahkan repository untuk Debian 11 (Bullseye)..."
            curl https://haproxy.debian.net/bernat.debian.org.gpg | gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
            echo "deb [signed-by=/usr/share/keyrings/haproxy.debian.net.gpg] http://haproxy.debian.net bullseye-backports-2.4 main" >/etc/apt/sources.list.d/haproxy.list
            apt-get update
            apt-get install haproxy=2.4.\* -y
            ;;
        "12")
            echo "Menambahkan repository untuk Debian 12 (Bookworm)..."
            curl https://haproxy.debian.net/bernat.debian.org.gpg | gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
            echo "deb [signed-by=/usr/share/keyrings/haproxy.debian.net.gpg] http://haproxy.debian.net bookworm-backports-2.6 main" >/etc/apt/sources.list.d/haproxy.list
            apt-get update
            apt-get install haproxy=2.6.\* -y
            ;;
        *)
            echo -e "OS Debian ${VERSION} tidak didukung."
            exit 1
            ;;
        esac

    else
        echo -e "Sistem Operasi Anda (${OS}) tidak didukung."
        exit 1
    fi

    echo -e "Instalasi selesai untuk ${OS} ${VERSION}."
}

clear
function nginx_install() {
if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
print_install "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
sudo apt-get install nginx -y
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
print_success "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
apt install -y nginx
else
echo -e " Your OS Is Not Supported ( ${YELLOW}$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${FONT} )"
fi
}

function base_package() {
    clear
    echo -e "\033[1;32m[INFO]\033[0m Menginstall Paket yang Dibutuhkan..."
    
    # restart 
    restart_paket() {
        # Konfigurasi tambahan
    systemctl enable chronyd
    systemctl restart chronyd
    systemctl enable chrony
    systemctl restart chrony
    chronyc sourcestats -v
    chronyc tracking -v
    ntpdate pool.ntp.org
    sudo apt-get clean all
    sudo apt-get autoremove -y
    }

   
    # Periksa OS dan versi
    OS=$(lsb_release -is)
    VERSION=$(lsb_release -rs | cut -d. -f1)

    # Paket khusus berdasarkan versi OS
    if [[ "$OS" == "Debian" ]]; then
        case $VERSION in
        10)
            echo -e "\033[1;32m[INFO]\033[0m Debian 10 detected. Installing additional packages..."
        apt install zip pwgen openssl netcat socat cron bash-completion -y
        apt install figlet -y
        apt update -y
        apt upgrade -y
        apt install bmon -y
        apt dist-upgrade -y
        systemctl enable chronyd
        systemctl restart chronyd
        systemctl enable chrony
        systemctl restart chrony
        chronyc sourcestats -v
        chronyc tracking -v
        apt install ntpdate -y
        ntpdate pool.ntp.org
        apt install sudo -y
        sudo apt-get clean all
        sudo apt-get autoremove -y
        sudo apt-get install -y debconf-utils
        sudo apt-get remove --purge exim4 -y
        sudo apt-get remove --purge ufw firewalld -y
        sudo apt-get install -y --no-install-recommends software-properties-common
        echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
        echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
        sudo apt-get install -y speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl build-essential gcc g++ python htop lsof tar wget curl ruby zip unzip p7zip-full python3-pip libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 ca-certificates lsb-release gcc shc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa
        restart_paket
            ;;
        11)
            echo -e "\033[1;32m[INFO]\033[0m Debian 11 detected. Installing additional packages..."
        apt install -y python-is-python3
        apt install zip pwgen openssl netcat socat cron bash-completion -y
        apt install figlet -y
        apt update -y
        apt upgrade -y
        apt install bmon -y
        apt dist-upgrade -y
        systemctl enable chronyd
        systemctl restart chronyd
        systemctl enable chrony
        systemctl restart chrony
        chronyc sourcestats -v
        chronyc tracking -v
        apt install ntpdate -y
        ntpdate pool.ntp.org
        apt install sudo -y
        sudo apt-get clean all
        sudo apt-get autoremove -y
        sudo apt-get install -y debconf-utils
        sudo apt-get remove --purge exim4 -y
        sudo apt-get remove --purge ufw firewalld -y
        sudo apt-get install -y --no-install-recommends software-properties-common
        echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
        echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
        sudo apt-get install -y speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl build-essential gcc g++ python htop lsof tar wget curl ruby zip unzip p7zip-full python3-pip libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 ca-certificates lsb-release gcc shc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa            
        
        restart_paket
            ;;
        12)
            echo -e "\033[1;32m[INFO]\033[0m Debian 12 detected. Installing additional packages..."
            apt install -y python3-venv
            ;;
        esac
    elif [[ "$OS" == "Ubuntu" ]]; then
        case $VERSION in
        20)
            echo -e "\033[1;32m[INFO]\033[0m Ubuntu 20.04 detected. Installing additional packages..."
        apt install zip pwgen openssl netcat socat cron bash-completion -y
        apt install figlet -y
        apt update -y
        apt upgrade -y
        apt install bmon -y
        apt dist-upgrade -y
        systemctl enable chronyd
        systemctl restart chronyd
        systemctl enable chrony
        systemctl restart chrony
        chronyc sourcestats -v
        chronyc tracking -v
        apt install ntpdate -y
        ntpdate pool.ntp.org
        apt install sudo -y
        sudo apt-get clean all
        sudo apt-get autoremove -y
        sudo apt-get install -y debconf-utils
        sudo apt-get remove --purge exim4 -y
        sudo apt-get remove --purge ufw firewalld -y
        sudo apt-get install -y --no-install-recommends software-properties-common
        echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
        echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
        sudo apt-get install -y speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl build-essential gcc g++ python htop lsof tar wget curl ruby zip unzip p7zip-full python3-pip libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 ca-certificates lsb-release gcc shc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa            
        restart_paket
            ;;
        22)
            echo -e "\033[1;32m[INFO]\033[0m Ubuntu 22.04 detected. Installing additional packages..."
        apt update -y
        apt upgrade -y        
        apt install -y zip pwgen openssl netcat socat cron bash-completion \
        figlet bmon ntpdate sudo debconf-utils iptables-persistent \
        speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev \
        libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev \
        flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix \
        zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl \
        build-essential gcc g++ python htop lsof sudo tar wget curl ruby zip unzip \
        p7zip-full python3-pip libc6 util-linux msmtp-mta ca-certificates \
        bsd-mailx iptables iptables-persistent netfilter-persistent net-tools \
        openssl gnupg gnupg2 python3-venv lsb-release shc make cmake git screen socat \
        xz-utils apt-transport-https gnupg1 dnsutils ntpdate chrony jq \
        openvpn easy-rsa
        sudo apt-get install -y --no-install-recommends software-properties-common
        
        # echo iptables
        echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
        echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
        
        # paket restart
        restart_paket
            ;;
        24)
            echo -e "\033[1;32m[INFO]\033[0m Ubuntu 24.04 detected. Installing additional packages..."
                # Dependencies ubuntu 24.04
    apt update -y
    apt install -y zip pwgen openssl netcat socat cron bash-completion \
        figlet bmon ntpdate sudo debconf-utils iptables-persistent \
        speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev \
        libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev \
        flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix \
        zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl \
        build-essential gcc g++ python htop lsof sudo tar wget curl ruby zip unzip \
        p7zip-full python3-pip libc6 util-linux msmtp-mta ca-certificates \
        bsd-mailx iptables iptables-persistent netfilter-persistent net-tools \
        openssl gnupg gnupg2 lsb-release shc make cmake git screen socat \
        xz-utils apt-transport-https gnupg1 dnsutils ntpdate chrony jq \
        openvpn easy-rsa
        sudo apt-get install -y --no-install-recommends software-properties-common
        
        # echo iptables
        echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
        echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
        
        # paket restart
        restart_paket        
            ;;
        esac
    else
        echo -e "\033[1;31m[ERROR]\033[0m Unsupported OS: $OS $VERSION"
        exit 1
    fi

    # print sukses
    echo -e "\033[1;32m[INFO]\033[0m Semua paket yang dibutuhkan telah diinstal."
}


clear
restart_system() {
USRSC=$(wget -qO- https://raw.githubusercontent.com/arivpnstores/izin/main/ip | grep $ipsaya | awk '{print $2}')
EXPSC=$(wget -qO- https://raw.githubusercontent.com/arivpnstores/izin/main/ip | grep $ipsaya | awk '{print $3}')
TIMEZONE=$(printf '%(%H:%M:%S)T')
domain=$(cat /root/domain)
TEXT="
<code>────────────────────</code>
<b> 🟢 NOTIFICATIONS INSTALL 🟢</b>
<code>────────────────────</code>
<code>ID     : </code><code>$USRSC</code>
<code>Domain : </code><code>$domain</code>
<code>Date   : </code><code>$TIME</code>
<code>Time   : </code><code>$TIMEZONE</code>
<code>Ip vps : </code><code>$ipsaya</code>
<code>Exp Sc : </code><code>$EXPSC</code>
<code>────────────────────</code>
<i>Automatic Notification from Github</i>
"'&reply_markup={"inline_keyboard":[[{"text":"⭐ᴏʀᴅᴇʀ⭐","url":"https://t.me/ARI_VPN_STORE"},{"text":"⭐ɪɴꜱᴛᴀʟʟ⭐","url":"https://wa.me/6281327393959"}]]}'
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}
clear
function INSTALL_SSL() {
    # Hapus file SSL lama
    rm -rf /etc/xray/xray.key /etc/xray/xray.crt
    DOMAIN_HOST=$(cat /etc/xray/domain)

    # Stop layanan pada port 80 jika ada
    STOPWEBSERVER=$(lsof -i:80 | awk 'NR==2 {print $1}')
    if [ ! -z "$STOPWEBSERVER" ]; then
        systemctl stop "$STOPWEBSERVER"
    fi
    systemctl stop nginx
    systemctl stop haproxy

    # Pastikan direktori .acme.sh ada
    mkdir -p /root/.acme.sh

    # Unduh dan instal acme.sh
    curl -s https://raw.githubusercontent.com/acmesh-official/acme.sh/master/acme.sh -o /root/.acme.sh/acme.sh
    if [ ! -f /root/.acme.sh/acme.sh ]; then
        echo -e "\e[91;1m Failed to download acme.sh. Check your internet connection or URL.\e[0m"
        exit 1
    fi

    chmod +x /root/.acme.sh/acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt

    # Request SSL certificate
    /root/.acme.sh/acme.sh --issue -d "$DOMAIN_HOST" --standalone -k ec-256
    if [ $? -ne 0 ]; then
        echo -e "\e[91;1m Failed to issue SSL certificate for $DOMAIN_HOST.\e[0m"
        exit 1
    fi

    # Instal sertifikat SSL
    /root/.acme.sh/acme.sh --installcert -d "$DOMAIN_HOST" \
        --fullchainpath /etc/xray/xray.crt \
        --keypath /etc/xray/xray.key \
        --ecc
    chmod 600 /etc/xray/xray.key /etc/xray/xray.crt
}

function RESTART_SERVICES() {
    echo -e "\e[92;1m Restarting services...\e[0m"
    systemctl restart nginx
    systemctl restart xray
    systemctl restart haproxy
    if [ $? -eq 0 ]; then
        echo -e "\e[92;1m All services restarted successfully.\e[0m"
    else
        echo -e "\e[91;1m Some services failed to restart. Check their status.\e[0m"
    fi
}
function install_cert() {
# Jalankan fungsi
INSTALL_SSL
RESTART_SERVICES
}


function make_folder_xray() {
rm -rf /etc/lunatic/vmess/.vmess.db
rm -rf /etc/lunatic/vless/.vless.db
rm -rf /etc/lunatic/trojan/.trojan.db
rm -rf /etc/lunatic/ssh/.ssh.db
rm -rf /etc/lunatic/bot/.bot.db

mkdir -p /etc/lunatic
mkdir -p /etc/limit
mkdir -p /etc/lunatic/vmess/ip
mkdir -p /etc/lunatic/vless/ip
mkdir -p /etc/lunatic/trojan/ip
mkdir -p /etc/lunatic/ssh/ip
mkdir -p /etc/lunatic/vmess/detail
mkdir -p /etc/lunatic/vless/detail
mkdir -p /etc/lunatic/trojan/detail
mkdir -p /etc/lunatic/ssh/detail

mkdir -p /etc/lunatic/vmess/usage
mkdir -p /etc/lunatic/vless/usage
mkdir -p /etc/lunatic/trojan/usage
mkdir -p /etc/lunatic/bot
mkdir -p /etc/lunatic/bot/notif
chmod +x /var/log/xray
mkdir -p /usr/bin/xray
mkdir -p /var/log/xray
mkdir -p /var/www/html
mkdir -p /usr/sbin/local

touch /etc/xray/domain
touch /var/log/xray/access.log
touch /var/log/xray/error.log
touch /etc/lunatic/vmess/.vmess.db
touch /etc/lunatic/vless/.vless.db
touch /etc/lunatic/trojan/.trojan.db
touch /etc/lunatic/ssh/.ssh.db
touch /etc/lunatic/bot/.bot.db
touch /etc/lunatic/bot/notif/key
touch /etc/lunatic/bot/notif/id
echo "& plughin Account" >>/etc/lunatic/vmess/.vmess.db
echo "& plughin Account" >>/etc/lunatic/vless/.vless.db
echo "& plughin Account" >>/etc/lunatic/trojan/.trojan.db
echo "& plughin Account" >>/etc/lunatic/ssh/.ssh.db
}
function install_xray() {
clear

# get ip and domain info
domain=$(< /root/domain)
IPVS=$(< /etc/xray/ipvps)

print_install "Core Xray 1.8.1 Latest Version"
domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
chown www-data.www-data $domainSock_dir
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $latest_version
wget -O /etc/xray/config.json "${REPO}cfg_conf_js/config.json" >/dev/null 2>&1
wget -O /etc/systemd/system/run_xray.service "${REPO}files/run_xray.service" >/dev/null 2>&1
print_success "Core Xray 1.8.1 Latest Version"
clear
curl -s ipinfo.io/city >>/etc/xray/city
curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp
cat >/etc/nginx/conf.d/xray.conf<<-END
server {
    listen 1010 proxy_protocol so_keepalive=on reuseport;
    set_real_ip_from 127.0.0.1;
    real_ip_header  proxy_protocol;
    server_name xxx;
    client_body_buffer_size 200K;
    client_header_buffer_size 2k;
    client_max_body_size 10M;
    large_client_header_buffers 3 1k;
    client_header_timeout 86400000m;
    keepalive_timeout 86400000m;
    add_header X-HTTP-LEVEL-HEADER 1;
    add_header X-ANOTHER-HTTP-LEVEL-HEADER 1;
    add_header X-XSS-Protection "1; mode=block";

    location ~ /vless {
    if ($http_upgrade != "Websocket") {
    rewrite /(.*) /vless break;
    }
    add_header X-HTTP-LEVEL-HEADER 1;
    add_header X-ANOTHER-HTTP-LEVEL-HEADER 1;
    add_header X-SERVER-LEVEL-HEADER 1;
    add_header X-LOCATION-LEVEL-HEADER 1;
    proxy_headers_hash_max_size 512;
    proxy_headers_hash_bucket_size 128;
    proxy_http_version 1.1;
    proxy_redirect off;
    proxy_pass http://127.0.0.1:10001;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $http_x_forwarded_for;
    proxy_set_header X-Forwarded-For $http_x_forwarded_for;
  }
    location ~ /vmess {
    if ($http_upgrade != "Websocket") {
    rewrite /(.*) /vmess break;
    }
    add_header X-HTTP-LEVEL-HEADER 1;
    add_header X-ANOTHER-HTTP-LEVEL-HEADER 1;
    add_header X-SERVER-LEVEL-HEADER 1;
    add_header X-LOCATION-LEVEL-HEADER 1;
    proxy_headers_hash_max_size 512;
    proxy_headers_hash_bucket_size 128;
    proxy_http_version 1.1;
    proxy_redirect off;
    proxy_pass http://127.0.0.1:10002;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $http_x_forwarded_for;
    proxy_set_header X-Forwarded-For $http_x_forwarded_for;
  } 
    location ~ /trojan-ws {
    if ($http_upgrade != "Websocket") {
    rewrite /(.*) /trojan-ws break;
    }
    add_header X-HTTP-LEVEL-HEADER 1;
    add_header X-ANOTHER-HTTP-LEVEL-HEADER 1;
    add_header X-SERVER-LEVEL-HEADER 1;
    add_header X-LOCATION-LEVEL-HEADER 1;
    proxy_headers_hash_max_size 512;
    proxy_headers_hash_bucket_size 128;
    proxy_http_version 1.1;
    proxy_redirect off;
    proxy_pass http://127.0.0.1:10003;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $http_x_forwarded_for;
    proxy_set_header X-Forwarded-For $http_x_forwarded_for;
  }
    location ~ /ss-ws {
    if ($http_upgrade != "Websocket") {
    rewrite /(.*) /ss-ws break;
    }
    add_header X-HTTP-LEVEL-HEADER 1;
    add_header X-ANOTHER-HTTP-LEVEL-HEADER 1;
    add_header X-SERVER-LEVEL-HEADER 1;
    add_header X-LOCATION-LEVEL-HEADER 1;
    proxy_headers_hash_max_size 512;
    proxy_headers_hash_bucket_size 128;
    proxy_http_version 1.1;
    proxy_redirect off;
    proxy_pass http://127.0.0.1:10004;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $http_x_forwarded_for;
    proxy_set_header X-Forwarded-For $http_x_forwarded_for;
  }
    location ~ / {
    if ($http_upgrade != "Websocket") {
    rewrite /(.*) /fightertunnelssh break;
    }
    add_header X-HTTP-LEVEL-HEADER 1;
    add_header X-ANOTHER-HTTP-LEVEL-HEADER 1;
    add_header X-SERVER-LEVEL-HEADER 1;
    add_header X-LOCATION-LEVEL-HEADER 1;
    proxy_headers_hash_max_size 512;
    proxy_headers_hash_bucket_size 128;
    proxy_http_version 1.1;
    proxy_redirect off;
    proxy_pass http://127.0.0.1:10015;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $http_x_forwarded_for;
    proxy_set_header X-Forwarded-For $http_x_forwarded_for;
  }
}
server {
    listen 1012 proxy_protocol so_keepalive=on reuseport;
    client_body_buffer_size 200K;
    client_header_buffer_size 2k;
    client_max_body_size 10M;
    large_client_header_buffers 3 1k;
    client_header_timeout 86400000m;
    keepalive_timeout 86400000m;
    server_name xxx;

    location ~ / {
    if ($http_upgrade != "Websocket") {
    rewrite /(.*) /fightertunnelovpn break;
    }
    add_header X-HTTP-LEVEL-HEADER 1;
    add_header X-ANOTHER-HTTP-LEVEL-HEADER 1;
    add_header X-SERVER-LEVEL-HEADER 1;
    add_header X-LOCATION-LEVEL-HEADER 1;
    proxy_headers_hash_max_size 512;
    proxy_headers_hash_bucket_size 128;
    proxy_http_version 1.1;
    proxy_redirect off;
    proxy_pass http://127.0.0.1:10012;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $http_x_forwarded_for;
    proxy_set_header X-Forwarded-For $http_x_forwarded_for;
  }
}
server {
    listen 81 ssl http2 reuseport;
    ssl_certificate /etc/xray/xray.crt;
    ssl_certificate_key /etc/xray/xray.key;
    ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
    ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
    root /var/www/html;
}
server {
    listen 1013 http2 proxy_protocol so_keepalive=on reuseport;
    client_body_buffer_size 200K;
    client_header_buffer_size 2k;
    client_max_body_size 10M;
    large_client_header_buffers 3 1k;
    client_header_timeout 86400000m;
    keepalive_timeout 86400000m;
    server_name xxx;
    location ~ /vless-grpc {
    add_header X-HTTP-LEVEL-HEADER 1;
    add_header X-ANOTHER-HTTP-LEVEL-HEADER 1;
    add_header X-SERVER-LEVEL-HEADER 1;
    add_header X-LOCATION-LEVEL-HEADER 1;
    proxy_headers_hash_max_size 512;
    proxy_headers_hash_bucket_size 128;
    proxy_http_version 1.1;
    proxy_redirect off;
    grpc_set_header Host $host;
    grpc_pass grpc://127.0.0.1:10005;
    grpc_set_header X-Real-IP $http_x_forwarded_for;
    grpc_set_header X-Forwarded-For $http_x_forwarded_for;
  }
    location ~ /vmess-grpc {
    add_header X-HTTP-LEVEL-HEADER 1;
    add_header X-ANOTHER-HTTP-LEVEL-HEADER 1;
    add_header X-SERVER-LEVEL-HEADER 1;
    add_header X-LOCATION-LEVEL-HEADER 1;
    proxy_headers_hash_max_size 512;
    proxy_headers_hash_bucket_size 128;
    proxy_http_version 1.1;
    proxy_redirect off;
    grpc_set_header Host $host;
    grpc_pass grpc://127.0.0.1:10006;
    grpc_set_header X-Real-IP $http_x_forwarded_for;
    grpc_set_header X-Forwarded-For $http_x_forwarded_for;
  }
    location ~ /trojan-grpc {
    add_header X-HTTP-LEVEL-HEADER 1;
    add_header X-ANOTHER-HTTP-LEVEL-HEADER 1;
    add_header X-SERVER-LEVEL-HEADER 1;
    add_header X-LOCATION-LEVEL-HEADER 1;
    proxy_headers_hash_max_size 512;
    proxy_headers_hash_bucket_size 128;
    proxy_http_version 1.1;
    proxy_redirect off;
    grpc_set_header Host $host;
    grpc_pass grpc://127.0.0.1:10007;
    grpc_set_header X-Real-IP $http_x_forwarded_for;
    grpc_set_header X-Forwarded-For $http_x_forwarded_for;
  }
    location ~ /ss-grpc {
    add_header X-HTTP-LEVEL-HEADER 1;
    add_header X-ANOTHER-HTTP-LEVEL-HEADER 1;
    add_header X-SERVER-LEVEL-HEADER 1;
    add_header X-LOCATION-LEVEL-HEADER 1;
    proxy_headers_hash_max_size 512;
    proxy_headers_hash_bucket_size 128;
    proxy_http_version 1.1;
    proxy_redirect off;
    grpc_set_header Host $host;
    grpc_pass grpc://127.0.0.1:10008;
    grpc_set_header X-Real-IP $http_x_forwarded_for;
    grpc_set_header X-Forwarded-For $http_x_forwarded_for;
  }
}
END
sed -i "s/xxx/${domain}/g" /etc/haproxy/haproxy.cfg
sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf

cat >/etc/nginx/nginx.conf<<-END
user www-data;
worker_processes auto;
error_log /var/log/nginx/error.log notice;
pid /var/run/nginx.pid;
events {
    worker_connections 1024;
}
http {
    log_format main '[$time_local] $proxy_protocol_addr "$http_user_agent"';
    access_log /var/log/nginx/access.log main;
    set_real_ip_from 127.0.0.1;

    include /etc/nginx/mime.types;
    include /etc/nginx/conf.d/xray.conf;
}
END

cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem
chmod +x /etc/systemd/system/runn.service
rm -rf /etc/systemd/system/xray.service.d

# xray service
cat >/etc/systemd/system/xray.service <<EOF
Description=Xray Service
Documentation=https://github.com
After=network.target nss-lookup.target
[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
filesNPROC=10000
filesNOFILE=1000000
[Install]
WantedBy=multi-user.target
EOF
print_success "Konfigurasi Packet"
}

function ssh(){
clear
print_install "Memasang Password SSH"
wget -O /etc/pam.d/common-password "${REPO}files/password"
chmod +x /etc/pam.d/common-password
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/altgr select The default for the keyboard layout"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/compose select No compose key"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/ctrl_alt_bksp boolean false"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layoutcode string de"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layout select English"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/modelcode string pc105"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/model select Generic 105-key (Intl) PC"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/optionscode string "
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/store_defaults_in_debconf_db boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/switch select No temporary switch"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/toggle select No toggling"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_layout boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_options boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_layout boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_options boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variantcode string "
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variant select English"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/xkb-keymap select "
cd
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END
cat > /etc/rc.local<<-END
exit 0
END
chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local.service
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
print_success "Password SSH"
}
function udp_mini(){
clear
print_install "Memasang Service limit Quota"
wget ${REPO}files/limit-quota.sh && chmod +x limit-quota.sh && ./limit-quota.sh
print_install "Memasang Service Locked xray"
wget ${REPO}lock-service.sh && chmod +x lock-service.sh && ./lock-service.sh
cd
mkdir -p /usr/bin/limit-ip
wget -q -O /usr/bin/limit-ip "${REPO}files/limit-ip"
chmod +x /usr/bin/*
cd /usr/bin
sed -i 's/\r//' limit-ip
cd
clear
cat >/etc/systemd/system/vmip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vmip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vmip
systemctl enable vmip
cat >/etc/systemd/system/vlip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vlip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vlip
systemctl enable vlip
cat >/etc/systemd/system/trip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip trip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart trip
systemctl enable trip
cat >/etc/systemd/system/ssip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip ssip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart ssip
systemctl enable ssip


mkdir -p /usr/lunatic/
wget -q -O /usr/lunatic/udp-mini "${REPO}files/udp-mini"
chmod +x /usr/lunatic/udp-mini
wget -q -O /etc/systemd/system/udp-mini-1.service "${REPO}files/udp-mini-1.service"
wget -q -O /etc/systemd/system/udp-mini-2.service "${REPO}files/udp-mini-2.service"
wget -q -O /etc/systemd/system/udp-mini-3.service "${REPO}files/udp-mini-3.service"
systemctl disable udp-mini-1
systemctl stop udp-mini-1
systemctl enable udp-mini-1
systemctl start udp-mini-1
systemctl disable udp-mini-2
systemctl stop udp-mini-2
systemctl enable udp-mini-2
systemctl start udp-mini-2
systemctl disable udp-mini-3
systemctl stop udp-mini-3
systemctl enable udp-mini-3
systemctl start udp-mini-3
print_success "files Quota Service"
}
clear
function ins_SSHD(){
clear
print_install "Memasang SSHD"
wget -q -O /etc/ssh/sshd_config "${REPO}files/sshd" >/dev/null 2>&1
chmod 700 /etc/ssh/sshd_config
/etc/init.d/ssh restart
systemctl restart ssh
/etc/init.d/ssh status
print_success "SSHD"
}
clear
function ins_dropbear(){
clear
print_install "Menginstall Dropbear"
apt-get install -y dropbear > /dev/null 2>&1
wget -q -O /etc/default/dropbear "${REPO}cfg_conf_js/dropbear.conf"
chmod +x /etc/default/dropbear
/etc/init.d/dropbear restart
/etc/init.d/dropbear status
print_success "Dropbear"
}
clear
function ins_vnstat(){
clear
print_install "Menginstall Vnstat"
apt -y install vnstat > /dev/null 2>&1
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev > /dev/null 2>&1
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
/etc/init.d/vnstat status
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6
print_success "Vnstat"
}
function ins_openvpn(){
clear
print_install "Menginstall OpenVPN"
wget ${REPO}ovpn/openvpn &&  chmod +x openvpn && ./openvpn
/etc/init.d/openvpn restart
print_success "OpenVPN"
}
function ins_backup(){
clear
print_install "Memasang Backup Server"
apt-get install -y rclone
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "${REPO}cfg_conf_js/rclone.conf"
cd /bin
git clone  https://github.com/LunaticTunnel/wondershaper.git
cd wondershaper
sudo make install
cd
rm -rf wondershaper
echo > /home/files
apt install msmtp-mta ca-certificates bsd-mailx -y
cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account default
host smtp.gmail.com
port 587
auth on
user oceantestdigital@gmail.com
from oceantestdigital@gmail.com
password jokerman77
logfile ~/.msmtp.log
EOF
chown -R www-data:www-data /etc/msmtprc
wget -q -O /etc/ipserver "${REPO}files/ipserver" && bash /etc/ipserver
print_success "Backup Server"
}
clear
function ins_swab(){
clear
print_install "Memasang Swap 1 G"
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
curl -sL "$gotop_link" -o /tmp/gotop.deb
dpkg -i /tmp/gotop.deb >/dev/null 2>&1
dd if=/dev/zero of=/swapfile bs=1024 count=1048576
mkswap /swapfile
chown root:root /swapfile
chmod 0600 /swapfile >/dev/null 2>&1
swapon /swapfile >/dev/null 2>&1
sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab
chronyd -q 'server 0.id.pool.ntp.org iburst'
chronyc sourcestats -v
chronyc tracking -v
wget ${REPO}files/bbr.sh &&  chmod +x bbr.sh && ./bbr.sh
print_success "Swap 1 G"
}
function ins_Fail2ban(){
clear
print_install "Menginstall Fail2ban"
if [ -d '/usr/local/ddos' ]; then
echo; echo; echo "Please un-install the previous version first"
exit 0
else
mkdir /usr/local/ddos
fi
clear
echo "Banner /etc/banner.txt" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/banner.txt"@g' /etc/default/dropbear
wget -O /etc/banner.txt "${REPO}banner/lunatic.site"
print_success "Fail2ban"
}
function ins_epro(){
clear
print_install "Menginstall ePro WebSocket Proxy"
wget -O /usr/bin/ws "${REPO}files/ws" >/dev/null 2>&1
wget -O /usr/bin/tun.conf "${REPO}cfg_conf_js/tun.conf" >/dev/null 2>&1
wget -O /etc/systemd/system/ws.service "${REPO}files/ws.service" >/dev/null 2>&1
chmod +x /etc/systemd/system/ws.service
chmod +x /usr/bin/ws
chmod 644 /usr/bin/tun.conf
systemctl disable ws
systemctl stop ws
systemctl enable ws
systemctl start ws
systemctl restart ws
wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1
wget -O /usr/sbin/ftvpn "${REPO}files/lttunnel" >/dev/null 2>&1
chmod +x /usr/sbin/ftvpn
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
cd
apt autoclean -y >/dev/null 2>&1
apt autoremove -y >/dev/null 2>&1
print_success "ePro WebSocket Proxy"
}
function ins_restart(){
clear
print_install "Restarting  All Packet"
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/vnstat restart
systemctl restart haproxy
/etc/init.d/cron restart
systemctl daemon-reload
systemctl start netfilter-persistent
systemctl enable --now nginx
systemctl enable --now xray
systemctl enable --now rc-local
systemctl enable --now dropbear
systemctl enable --now openvpn
systemctl enable --now cron
systemctl enable --now haproxy
systemctl enable --now netfilter-persistent
systemctl enable --now ws
systemctl enable --now fail2ban
history -c
echo "unset HISTFILE" >> /etc/profile
cd
rm -f /root/openvpn
rm -f /root/key.pem
rm -f /root/cert.pem
print_success "All Packet"
}
function menu(){
clear
print_install "Memasang Menu Packet"

# install menu shell
wget ${REPO}feature/LUNA_sh
unzip LUNA_sh
chmod +x menu/*
mv menu/* /usr/local/sbin
rm -rf menu

# install menu py
wget ${REPO}feature/LUNA_py
unzip LUNA_py
chmod +x menu/*
mv menu/* /usr/bin
rm -rf menu
}
function profile(){
cat >/root/.profile <<EOF
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
python3 /usr/bin/menu
EOF

cat >/etc/cron.d/xp_all <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 0 * * * root /usr/local/sbin/xp
END
cat >/etc/cron.d/logclean <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/10 * * * * root /usr/local/sbin/clearlog
END
chmod 644 /root/.profile
cat >/etc/cron.d/daily_reboot <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 5 * * * root /sbin/reboot
END
echo "*/1 * * * * root echo -n > /var/log/nginx/access.log" >/etc/cron.d/log.nginx
echo "*/1 * * * * root echo -n > /var/log/xray/access.log" >>/etc/cron.d/log.xray
service cron restart
cat >/home/daily_reboot <<-END
5
END
cat >/etc/systemd/system/rc-local.service <<EOF
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
EOF
echo "/bin/false" >>/etc/shells
echo "/usr/sbin/nologin" >>/etc/shells
cat >/etc/rc.local <<EOF
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
systemctl restart netfilter-persistent
exit 0
EOF
chmod +x /etc/rc.local
AUTOREB=$(cat /home/daily_reboot)
SETT=11
if [ $AUTOREB -gt $SETT ]; then
TIME_DATE="PM"
else
TIME_DATE="AM"
fi
print_success "Menu Packet"
}
function enable_services(){
clear
print_install "Enable Service"
systemctl daemon-reload
systemctl start netfilter-persistent
systemctl enable --now rc-local
systemctl enable --now cron
systemctl enable --now netfilter-persistent
systemctl restart nginx
systemctl restart xray
systemctl restart cron
systemctl restart haproxy
print_success "Enable Service"
clear
}
clear_all() {
history -c
rm -rf /root/menu
rm -rf /root/*.zip
rm -rf /root/*.sh
rm -rf /root/LICENSE
rm -rf /root/README.md
rm -rf /root/domain
secs_to_human "$(($(date +%s) - ${start}))"
sudo hostnamectl set-hostname $username
}

fun_bar haproxy_install_config
fun_bar base_package
fun_bar first_setup
fun_bar nginx_install
fun_bar make_folder_xray
fun_bar password_default
fun_bar install_cert
fun_bar install_xray
fun_bar ssh
fun_bar udp_mini
fun_bar ssh_slow
fun_bar ins_SSHD
fun_bar ins_dropbear
fun_bar ins_vnstat
fun_bar ins_openvpn
fun_bar ins_backup
fun_bar ins_swab
fun_bar ins_Fail2ban
fun_bar ins_epro
fun_bar ins_restart
fun_bar menu
fun_bar profile
fun_bar enable_services
fun_bar restart_system
fun_bar clear_all


clear
echo -e ""
echo -e "   \e[97;1m ===========================================\e[0m"
echo -e "   \e[92;1m     Install Succesfully bro! Good Job!     \e[0m"
echo -e "   \e[97;1m ===========================================\e[0m"
echo ""
read -p "$( echo -e "Press ${YELLOW}[ ${NC}${YELLOW}Enter${NC} ${YELLOW}]${NC} TO REBOOT") "
reboot
