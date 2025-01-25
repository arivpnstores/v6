#!/bin/bash
clear

# Repo GitHub
GIT_CMD="https://raw.githubusercontent.com/arivpnstores/v6/main/AUTOKILL_SERVICE"

# Daftar layanan yang akan diunduh
SERVICES=("kill-vme" "kill-vle" "kill-tro" "kill-ssh")

# Loop untuk mengunduh dan mengatur izin layanan
for service in "${SERVICES[@]}"; do
    FILE_PATH="/etc/systemd/system/${service}.service"
    
    # Unduh file service
    wget -q -O "$FILE_PATH" "${GIT_CMD}/${service}.service"
    
    # Cek apakah file berhasil diunduh
    if [[ ! -f "$FILE_PATH" ]]; then
        echo "Gagal mengunduh ${service}.service"
        exit 1
    fi

    # Beri izin eksekusi
    chmod +x "$FILE_PATH"
    
    # Aktifkan dan restart layanan
    systemctl daemon-reload
    systemctl enable "$service"
    systemctl restart "$service"
    
    echo "Berhasil menginstal dan menjalankan ${service}"
done
