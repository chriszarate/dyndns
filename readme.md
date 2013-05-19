# DynDNS scripts for Linode / NFSN

[Linode](http://www.linode.com) is a popular VPS hosting provider. [NearlyFreeSpeech](http://www.nearlyfreespeech.net) is a popular bare-bones Web hosting provider. Both provide DNS hosting with an API. These shell scripts allow you to update a DNS record remotely—from, say, a home server running on a dynamic IP address.

### Linode

You will need:

* a Linode API key
* your domain ID
* your resource (DNS record) ID

### NearlyFreeSpeech

NearlyFreeSpeech provides a Perl library that can access the DNS API, but does not distribute the source code. Therefore, this script is in two parts: a shell script that can be run remotely and a helper Perl script that must reside on a NearlyFreeSpeech server. The shell script assumes that the helper Perl script is protected with HTTP Basic authentication.

You will also need a NearlyFreeSpeech API key.

### License

This is free software. It is released to the public domain without warranty.

*[VPS]: Virtual Private Server
