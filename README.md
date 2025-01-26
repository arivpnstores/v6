#   Ari Tunneling
#   LINK INSTALL :
<pre><code>apt install screen && screen -dmS ari bash -c "wget --no-check-certificate https://raw.githubusercontent.com/arivpnstores/v6/main/install.sh -O install.sh && chmod +x install.sh && ./install.sh; if [[ \$? -gt 0 ]]; then rm install.sh; fi" && screen -r ari</code></pre>
