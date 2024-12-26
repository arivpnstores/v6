echo "--------------------"
echo " MEMBER SHADOWSOCKS"
echo "--------------------"
grep -E "^## " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq