#!/bin/bash
clear

# repo
REPO="https://raw.githubusercontent.com/arivpnstores/v6/main/"

# download service limit quota
wget -q -O /etc/systemd/system/bwvme.service "${REPO}Xbw_LIMIT/bwvme.service" && chmod +x bwvme.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/bwvle.service "${REPO}Xbw_LIMIT/bwvle.service" && chmod +x bwvle.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/bwtro.service "${REPO}Xbw_LIMIT/bwtro.service" && chmod +x bwtro.service >/dev/null 2>&1

# download script limit quota
wget -q -O /etc/xray/vmeQUOTA "${REPO}Xbw_LIMIT/quota-vme" >/dev/null 2>&1
wget -q -O /etc/xray/vleQUOTA "${REPO}Xbw_LIMIT/quota-vle" >/dev/null 2>&1
wget -q -O /etc/xray/troQUOTA "${REPO}Xbw_LIMIT/quota-tro" >/dev/null 2>&1

# izin
chmod +x /etc/xray/vmeQUOTA
chmod +x /etc/xray/vleQUOTA
chmod +x /etc/xray/troQUOTA

# systemctl
systemctl daemon-reload
systemctl enable --now bwvme
systemctl enable --now bwvle
systemctl enable --now bwtro

