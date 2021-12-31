# pihole-doh

Docker Compose-based pihole deployment for getting up and running with DNS Over HTTPS. Spins up two containers:

1. An instance of `cloudflared` (image provided by [crazymax/cloudflared](https://github.com/crazy-max/docker-cloudflared)) for proxying DNS lookups to DNS Over HTTPS servers provided by [Cloudflare (1.1.1.1)](https://1.1.1.1/dns/) and [Quad9 (9.9.9.9)](https://www.quad9.net). The proxy handles DNS queries on port 5053, though this is only exposed on the local Docker network.
1. A `pi-hole` instance (official image [pi-hole/docker-pi-hole](https://github.com/pi-hole/docker-pi-hole)) configured to use the above DoH proxy as its upstream.

## Running

### Prerequisites

1. Docker installed and running
1. Docker Compose installed
1. Make installed

### Commands

#### Start

```zsh
make rebuild # Builds and starts the containers
```

Pi-Hole’s web interface should now be accessible at `http://localhost:5550`.

To test that the Pi-Hole’s DNS server is working, run `nslookup google.com 127.0.0.1`. You should get a response back.

#### Stop

```zsh
make stop # Stops the containers
```

#### Other

If you'd rather not use the provided `make` targets, you can also run as a standard Compose application via `docker-compose up -d`, etc. You can interact with the containers using `docker-compose` or `docker` as well, of course.

## Host Ports

The `cloudflared` ports are not exposed on the host. Pi-Hole’s web interface is exposed on a port controlled by the `PIHOLE_WEB_PORT` environment variable in your local shell. DNS queries into the Pi-Hole go to port 53.

## Persistence

Pi-Hole writes its persistence data to `./etc-pihole` and `./etc-dnsmasq`. To reset the instance between runs, delete these directories.

## Configuration

### `PIHOLE_WEB_PORT`

> Default: 5550

Set this environment variable in your local shell to change the port where Pi-Hole's web interface can be accessed.

### Pi-Hole Web Password

Pi-Hole generates a new web interface password when it starts up, by default. To set a static password that won't change between runs, add a `docker-compose.override.yml` file to the root of the repository with the following contents:

```yaml
version: "3"
services:
  pihole:
    environment:
      WEBPASSWORD: 'your_password_here'
```
