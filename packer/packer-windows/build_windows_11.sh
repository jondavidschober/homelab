#!/bin/bash
set -x
#  --var iso_url=~/packer_cache/msdn/en-us_windows_11_consumer_editions_x64_dvd_bd3cf8df.iso \
#  --var iso_checksum=sha256:667bd113a4deb717bc49251e7bdc9f09c2db4577481ddfbce376436beb9d1d2f \
#  --var autounattend=tmp/11_pro/Autounattend.xml \
rm -rf tmp/windows11iso/
mkdir -p tmp/windows11iso/
cp -r  scripts/* tmp/windows11iso/
sed -e "s/\${product_key}/`cat windows11.key`/" answer_files/11/Autounattend.xml > tmp/windows11iso/Autounattend.xml

genisoimage -J -joliet-long -r -o tmp/windows11.iso tmp/windows11iso
cp tmp/windows11.iso /mnt/pve/NAS-NFS/ipxeboot/
packer build --var auto_iso_checksum="sha256:$(sha256sum tmp/windows11.iso  | cut -d' ' -f1)"  windows_11.json.pkr.hcl

