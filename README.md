
# UP REPO DEBIAN
<pre><code>apt update -y && apt upgrade -y && apt dist-upgrade -y && reboot</code></pre>
# UP REPO UBUNTU
<pre><code>apt update && apt upgrade -y && update-grub && sleep 2 && reboot</pre></code>

### INSTALL SCRIPT 
<pre><code>apt dist-upgrade -y && update-grub && wget -q https://raw.githubusercontent.com/kanggacorvpn/vpnscripts/main/ins.sh && chmod +x ins.sh && ./ins.sh
</code></pre>

### TESTED ON OS 
- UBUNTU 20,22,24
- DEBIAN 10,11,12
