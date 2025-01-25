#!/bin/bash

 Mengunduh dan mengekstrak menu.zip
apt update -y
apt install -y unzip

    wget https://raw.githubusercontent.com/arivpnstores/v6/main/menu/Ari_sh.zip
    unzip Ari_sh.zip
    chmod +x Ari_sh/*
    mv Ari_sh/* /usr/local/sbin
    rm -rf Ari_sh.zip
    rm -rf Ari_sh
    
    wget https://raw.githubusercontent.com/arivpnstores/v6/main/menu/Ari_py.zip
    unzip Ari_py.zip
    chmod +x Ari_py/*
    mv Ari_py/* /usr/bin
    rm -rf Ari_py.zip
    rm -rf Ari_py    
