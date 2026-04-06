# self-hosted stack template

This template uses [`traefik`](https://doc.traefik.io/traefik/) as the reverse proxy.
It takes care of TLS termination and routing to each service depending on the requested host.
The current expectation is that each service is available under its dedicated domain.

TLS certificates are requested using the Let's Encrypt certificate resolver.
You can use either the TLS or DNS challenge.
The DNS challenge is particularly useful if you want to use a wildcard domain, i.e., you have one wildcard certificate for all subdomains of a domain.

## Copy this template

```shell
uvx copier copy --trust https://github.com/mschoettle/self-hosted.git
```
