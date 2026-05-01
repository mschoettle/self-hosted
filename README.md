# self-hosted stack template

This template provides you with a stack to self-host various services.
It is perfect to run on a small server, or in your home network, for example on a Raspberry Pi.

## Features

This stack uses [`traefik`](https://doc.traefik.io/traefik/) as the reverse proxy.
It takes care of TLS termination and routing to each service depending on the requested host.
The current expectation is that each service is available under its dedicated domain.

TLS certificates are requested using the Let's Encrypt certificate resolver.
You can use either the [TLS or DNS challenge](https://doc.traefik.io/traefik/reference/install-configuration/tls/certificate-resolvers/acme/#the-different-acme-challenges).
The DNS challenge is particularly useful if you want to use a wildcard domain, i.e., you have one wildcard certificate for all subdomains of a domain.

These are the available services that are currently supported by this template.
They are all optional:

- [Pi-hole](https://pi-hole.net/): Network-wide ad blocking
- [Nextcloud](https://nextcloud.com/): Content collaboration platform, e.g., used for file hosting
  - [Valkey](https://valkey.io/) (a Redis fork) is used for [memory caching](https://docs.nextcloud.com/server/stable/admin_manual/configuration_server/caching_configuration.html#recommendations-based-on-type-of-deployment)
- [Forgejo](https://forgejo.org/): Git hosting with collaborative features (like GitHub)
- [Umami](https://umami.is/): Privacy-focused web analytics

Some services require a database.
A [PostgreSQL](https://www.postgresql.org/) database service is added if a service is chosen that requires one.

## Copy this template

```shell
uvx --with copier-templates-extensions copier copy --trust https://github.com/mschoettle/self-hosted.git
```
