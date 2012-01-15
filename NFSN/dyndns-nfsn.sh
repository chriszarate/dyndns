#!/bin/sh
# Dynamic DNS updater for NFSN

# DNS record
DNS_RECORD=your-subdomain

# Helper script
SCRIPT_URL=http://example.com/helper_script/
USERNAME=username
PASSWORD=password

# Set file location preferences
IP_FILE=/path/to/current_ip.txt
LOG_FILE=/path/to/dyndns.log

# Get current external IP address
CURRENT_IP=`wget http://www.slurpware.org/ -q -O -`

# Get previous external IP adress
ARCHIVE_IP=0.0.0.0
if [ -f $IP_FILE ]; then
   ARCHIVE_IP=`awk 'NR==1 {print;exit}' ${IP_FILE}`
fi

# If IP address has changed, update record
if [ "$ARCHIVE_IP" != "$CURRENT_IP" ]; then
  curl -s -u ${USERNAME}:${PASSWORD} -o $LOG_FILE ${SCRIPT_URL}?record=${DNS_RECORD}
  echo $CURRENT_IP > $IP_FILE
fi