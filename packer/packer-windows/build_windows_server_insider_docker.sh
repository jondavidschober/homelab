#!/bin/bash

# Windows Insider ISO
PACKER_LOG=debug packer build \
  --only=vmware-iso \
  --var vhv_enable=true \
  --var iso_url=~/packer_cache/insider/Windows_InsiderPreview_Server_en-us_19035.iso \
  windows_server_insider_docker.json
