#!/bin/sh
# Dynamic DNS updater for NFSN

# Helper script
URL=http://example.com/dyndns-nfsn-helper.php
PASSPHRASE=passphrase
FQDN=subdomain.example.com

# Log file
LOG=~/log/dyndns-updated.log
NOUPDATE=~/log/dyndns-noupdate.log

# Get IP addresses
NOW=`dig +short myip.opendns.com @resolver1.opendns.com`
LAST=`dig +short $FQDN`

# If IP address has changed, update record
if [ -n "$NOW" ] && [ -n "$LAST" ] && [ "$LAST" != "$NOW" ]; then
  curl -s ${URL}?knock=${PASSPHRASE} >> $LOG
  echo "" >> $LOG
else
  touch $NOUPDATE
fi
