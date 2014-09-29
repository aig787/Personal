#!/bin/sh
if [[ $UID -ne 0 ]]; then
    echo "$0 must be run as root"
    exit 1
fi

pacman -S snapper
snapper -c root create-config /
cp ../Configs/root /etc/snapper/configs/root
chown root /etc/snapper/configs/root
chgrp root /etc/snapper/configs/root
cp ../Downloaded\ Scripts/snp /usr/local/bin/snp
