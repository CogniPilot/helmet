#!/bin/bash
set -e

VNCPASSWD="$1"

# setup vnc
mkdir ~/.vnc && echo "$VNCPASSWD" | /opt/TurboVNC/bin/vncpasswd -f > ~/.vnc/passwd && \
  chmod 600 ~/.vnc/passwd && \
  openssl req -x509 -nodes -newkey rsa:3702 -keyout ~/.vnc/x509_private.pem -out ~/.vnc/x509_cert.pem -days 3650 -subj '/CN=www.mydom.com/O=My Company Name LTD./C=US'
