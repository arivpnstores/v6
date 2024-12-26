REPO="https://raw.githubusercontent.com/LunatiX-nc/excorzscriptlunatix/main/"
wget -q -O /etc/systemd/system/limitvmess.service "${REPO}files/limitvmess.service" && chmod +x limitvmess.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limitvless.service "${REPO}files/limitvless.service" && chmod +x limitvless.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limittrojan.service "${REPO}files/limittrojan.service" && chmod +x limittrojan.service >/dev/null 2>&1
wget -q -O /etc/systemd/system/limitshadowsocks.service "${REPO}files/limitshadowsocks.service" && chmod +x limitshadowsocks.service >/dev/null 2>&1
 # // service quota xray
wget -q -O /etc/xray/quota-vme "${REPO}files/quota-vme" >/dev/null 2>&1
wget -q -O /etc/xray/quota-vle "${REPO}files/quota-vle" >/dev/null 2>&1
wget -q -O /etc/xray/quota-tro "${REPO}files/quota-tro" >/dev/null 2>&1
wget -q -O /etc/xray/quota-ssr "${REPO}files/quota-ssr" >/dev/null 2>&1
chmod +x /etc/xray/quota-vme
chmod +x /etc/xray/quota-vle
chmod +x /etc/xray/quota-tro
chmod +x /etc/xray/quota-ssr
systemctl daemon-reload
systemctl enable --now limitvmess
systemctl enable --now limitvless
systemctl enable --now limittrojan
systemctl enable --now limitshadowsocks