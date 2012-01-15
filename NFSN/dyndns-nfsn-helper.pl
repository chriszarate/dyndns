#!/usr/bin/perl
# Dynamic DNS helper script for NFSN
# Rename to index.pl and protect with HTTP Basic authentication

use Net::DNS;
use WebService::NFSN;
use CGI;
use strict;

# Create CGI object
my $cgi = new CGI;

# Config
my $username     = 'username';
my $api_key      = 'your_api_key';
my $subdomain    = $cgi->param('record');
my $domain       = 'example.com';
my $type         = 'A';
my $ttl          = '600';
my $name_server1 = 'ns.phx1.nearlyfreespeech.net';
my $name_server2 = 'ns.phx2.nearlyfreespeech.net';
my $record_path  = '/home/protected/dns/';

# Send header:
print "Content-type: text/html\n\n";

# Avoid needless api calls
if ($subdomain eq '') { print "Nothing to update.\n\n"; exit; }

# Get old IP address
my $resolver = Net::DNS::Resolver->new;
   $resolver->nameservers($name_server1, $name_server2);
my $fqdn = $subdomain . '.' . $domain;
my $old_ip = ($resolver->send($fqdn . '.', $type)->answer)[0]->rdatastr;

# Get new IP address
my $new_ip = $cgi->remote_host();

# Avoid needless api calls
if ($old_ip eq $new_ip) { print "No update: IP address has not changed ($new_ip).\n\n"; exit; }
if ($new_ip eq 'localhost' or $new_ip eq '') { print "Invalid or blank IP address ($new_ip).\n\n"; exit; }

# Update DNS
my $dns_record = WebService::NFSN->new($username, $api_key)->dns($domain);
   $dns_record->removeRR(name => $subdomain, type => $type, data => $old_ip);
   $dns_record->addRR(name => $subdomain, type => $type, data => $new_ip, ttl => $ttl);

# Print result
print "Record updated: $fqdn\n";
print "Old IP: $old_ip\n";
print "New IP: $new_ip\n\n";

# Write to file
open FILE, ">" . $record_path . $subdomain or die $!;
print FILE $new_ip;
close FILE;