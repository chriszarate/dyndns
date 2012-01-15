#!/bin/sh
# Dynamic DNS updater for Linode API

# DNS record
DNS_RECORD=subdomain
RECORD_TYPE=A

# Linode API
API_KEY=your_api_key
DOMAIN_ID=your_domain_id
RESOURCE_ID=your_resource_id

# Logs
IP_FILE=/path/to/current_ip.txt
LOG_FILE=/path/to/dyndns.log

# Get current external IP address
CURRENT_IP=`wget http://www.slurpware.org/ -q -O -`

# Get previous external IP adress
ARCHIVE_IP=0.0.0.0
if [ -f $IP_FILE ]; then
   ARCHIVE_IP=`awk 'NR==1 {print;exit}' $IP_FILE`
fi

# If IP address has changed, update DNS record
if [ "$ARCHIVE_IP" != "$CURRENT_IP" ]; then
  curl -k -s -o $LOG_FILE https://api.linode.com/api/?api_key=${API_KEY}\&action=domainResourceSave\&DomainID=${DOMAIN_ID}\&ResourceID=${RESOURCE_ID}\&Name=${DNS_RECORD}\&Type=${RECORD_TYPE}\&Target=${CURRENT_IP}
  echo $CURRENT_IP > $IP_FILE
fi