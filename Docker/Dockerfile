FROM debian:stable
USER root

# add the ca root cert for https inspection (customization for https inspection environment)
RUN openssl s_client -showcerts -verify 5 -connect google.com:443 < /dev/null | awk '/BEGIN CERTIFICATE/,/END CERTIFICATE/{ if(/BEGIN CERTIFICATE/){a++}; out="/usr/share/ca-certificates/cert-"a".crt"; print > out }' 
RUN ls -r /usr/share/ca-certificates | grep "cert-*" | head -n 1 >> /etc/ca-certificates.conf
RUN ls /usr/share/ca-certificates
RUN update-ca-certificates
# update self signed cert for Java
WORKDIR "/usr/share/ca-certificates"
RUN for i in cert-*.crt; do keytool -importcert -noprompt -alias $i -cacerts -storepass changeit -file "$i"; done
