FROM amazonlinux:2

WORKDIR /app

RUN yum update -y
RUN yum install -y wget

RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-x86_64.rpm
RUN yum install -y ./cloudflared-linux-x86_64.rpm
# RUN cloudflared -v

EXPOSE 5053/tcp 5053/udp

CMD cloudflared proxy-dns --port 5053 --address 0.0.0.0 --upstream https://1.1.1.1/dns-query --upstream https://1.0.0.1/dns-query --upstream https://dns.quad9.net/dns-query --upstream https://dns9.quad9.net/dns-query
