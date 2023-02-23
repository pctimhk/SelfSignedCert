#!/usr/bash
openssl s_client -showcerts -verify 5 -connect google.com:443 < /dev/null | awk '/BEGIN CERTIFICATE/,/END CERTIFICATE/{ if(/BEGIN CERTIFICATE/){a++}; out="/usr/share/ca-certificates/cert-"a".crt"; print > out }' 
cd /usr/share/ca-certificates
for i in cert-*.crt; do keytool -importcert -noprompt -alias $i -cacerts -storepass changeit -file "$i"; done