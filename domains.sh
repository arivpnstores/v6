#!/bin/bash

    clear
    echo -e "\033[96;1m =============================== \033[0m"
    echo -e "\033[96;1m    MEMBUAT DOMAINS UNTUK VPS    \033[0m"    
    echo -e "\033[96;1m =============================== \033[0m"    
    IP=$(curl -sS ipv4.icanhazip.com)
    DOMAIN=klmpk.my.id
    sub=$(head /dev/urandom | tr -dc a-z0-9 | head -c 8)
    dns=${sub}.${DOMAIN}
    CF_KEY=9d25535086484fb695ab64a70a70532a32fd4
    CF_ID=andyyuda41@gmail.com
    set -euo pipefail
    echo ""
    echo "Proses Pointing Domain ${dns}..."
    sleep 1
    ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
         -H "X-Auth-Email: ${CF_ID}" \
         -H "X-Auth-Key: ${CF_KEY}" \
         -H "Content-Type: application/json" | jq -r .result[0].id)

    RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${dns}" \
         -H "X-Auth-Email: ${CF_ID}" \
         -H "X-Auth-Key: ${CF_KEY}" \
         -H "Content-Type: application/json" | jq -r .result[0].id)

    if [[ "${#RECORD}" -le 10 ]]; then
         RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
         -H "X-Auth-Email: ${CF_ID}" \
         -H "X-Auth-Key: ${CF_KEY}" \
         -H "Content-Type: application/json" \
         --data '{"type":"A","name":"'${dns}'","content":"'${IP}'","ttl":120,"proxied":true}' | jq -r .result.id)
    fi

    RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
         -H "X-Auth-Email: ${CF_ID}" \
         -H "X-Auth-Key: ${CF_KEY}" \
         -H "Content-Type: application/json" \
         --data '{"type":"A","name":"'${dns}'","content":"'${IP}'","ttl":120,"proxied":true}')

    # Menyimpan domain ke /etc/xray/domain hanya jika tidak ada
    echo "$dns" > /etc/xray/domain
    clear

    echo -e "\033[96m================================\033[0m"    
    echo -e "\e[96;1mYOUR DOMAIN:\e[0m ${dns}"
    echo -e "\033[96m================================\033[0m"    
rm -rf /etc/xray/domain 

goblox="${dns}" 
echo "${goblox}" > /etc/xray/domain
clear