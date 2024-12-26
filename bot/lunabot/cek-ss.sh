#!/bin/bash

function con() {
    local -i bytes=$1;
    if ((bytes < 1024)); then
        echo "${bytes}B"
    elif ((bytes < 1048576)); then
        echo "$(( (bytes + 1023)/1024 ))KB"
    elif ((bytes < 1073741824)); then
        echo "$(( (bytes + 1048575)/1048576 ))MB"
    else
        echo "$(( (bytes + 1073741823)/1073741824 ))GB"
    fi
}

clear

echo -n > /tmp/other.txt
data=($(grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq))

echo "━━━━━━━━━━━━━━━━━━"
echo "| LIST ONLINE SHADOWSOCKS |"
echo "━━━━━━━━━━━━━━━━━━"

for akun in "${data[@]}"; do
    if [[ -z "$akun" ]]; then
        akun="tidakada"
    fi

    echo -n > /tmp/ipxray.txt
    data2=( $(grep -w "$akun" /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort -u) )

    for ip in "${data2[@]}"; do
        jum=$(grep -w "$akun" /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort -u)

        if [[ "$jum" = "$ip" ]]; then
            echo "$jum" >> /tmp/ipxray.txt
        else
            echo "$ip" >> /tmp/other.txt
        fi
    done

    jum=$(cat /tmp/ipxray.txt)

    if [[ -n "$jum" ]]; then
        jum2=$(nl /tmp/ipxray.txt)
        lastlogin=$(grep -w "$akun" /var/log/xray/access.log | tail -n 500 | cut -d " " -f 2 | tail -1)

        echo -e "user: ${akun}\nOnline Jam: ${lastlogin} WIB"
        echo -e "$jum2"
        echo ""
    fi

done
rm -rf /tmp/other.txt

rm -rf /tmp/ipxray.txt