#!/bin/bash
# KaliPenHub Installation Script for Kali Linux
# This will install all dependencies and set up the tool correctly

# Check for root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (sudo ./install.sh)"
  exit 1
fi

# Check for Kali Linux
if ! grep -q "Kali" /etc/os-release; then
  echo "Warning: This tool is optimized for Kali Linux"
  read -p "Continue anyway? [y/N] " -n 1 -r
  echo
  [[ ! $REPLY =~ ^[Yy]$ ]] && exit 1
fi

# Update and install dependencies
echo "[*] Updating packages and installing dependencies..."
apt update && apt install -y \
  python3 \
  python3-pip \
  python3-tk \
  nmap \
  git \
  python3-scapy

# Install Python packages
pip3 install \
  customtkinter \
  python-nmap \
  requests

# Clone repository
echo "[*] Downloading KaliPenHub..."
git clone https://github.com/JorisvanderVuurst/kalipenhub.git /opt/kalipenhub

# Make executable
chmod +x /opt/kalipenhub/kalipenhub.py

# Create symlink
ln -s /opt/kalipenhub/kalipenhub.py /usr/local/bin/kalipenhub

echo "[+] Installation complete!"
echo "Run KaliPenHub with: kalipenhub"
