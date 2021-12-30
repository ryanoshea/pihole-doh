FROM amazonlinux:2

ENV PORT=5053

WORKDIR /app

RUN yum update -y
RUN yum install -y wget

RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-x86_64.rpm
RUN yum install -y ./cloudflared-linux-x86_64.rpm
# RUN cloudflared -v

EXPOSE $PORT/tcp $PORT/udp

CMD cloudflared proxy-dns --port ${PORT} --address 0.0.0.0 --upstream https://1.1.1.1/dns-query --upstream https://1.0.0.1/dns-query --upstream https://dns.quad9.net/dns-query --upstream https://dns9.quad9.net/dns-query

HEALTHCHECK --interval=30s --timeout=20s --start-period=10s \
  CMD dig +short @127.0.0.1 -p ${PORT} cloudflare.com A || exit 1
