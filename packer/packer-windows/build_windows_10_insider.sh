#!/bin/bash
packer build --only=vmware-iso \
  --var iso_url=~/packer_cache/insider/Windows10_InsiderPreview_Client_x64_en-us_20150.iso \
  --var iso_checksum=sha256:368483372dd7c391ee02d1847630fbba89f5ed014389ce0b942ed7863bd2b04c \
  --var autounattend=tmp/10_pro/Autounattend.xml \
  windows_10_insider.json

# packer build --only=vmware-iso \
#   --var iso_url=~/packer_cache/insider/uupdump_19041.1_PROFESSIONAL_X64_EN-US.iso \
#   --var iso_checksum=sha256:bcf500c09e2048c8bd2b710ba2b75bed9fe6ef07ea2a584599af81b4b8baa5ed \
#   --var autounattend=tmp/10_pro/Autounattend.xml \
#   windows_10_insider.json
