# nuxt

Step 1: Create a `Dockerfile` in your project root
```
FROM bitkanlabs/nuxt:8.11.2-onbuild
MAINTAINER Clark Wang <clark@bitkan.com>
```

Step 2: Run `docker build`
```
$ docker build -t your-image-name:with-tag .
```

Or you can use docker compose with `docker-compose.xml`
```
version: '3'

services:
  proxy:
    image: traefik:1.6
    command: --api --docker
    privileged: false
    restart: always
    networks:
      - nuxt
    ports:
      - "80:80"
      - "8080:8080"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
  web:
    build: .
    image: your-image-name:with-tag
    privileged: false
    restart: always
    networks:
      - nuxt
    expose:
      - 3000
    labels:
      - "traefik.backend=web"
      - "traefik.docker.network=nuxt"
      - "traefik.enable=true"
      - "traefik.port=3000"
      - "traefik.frontend.rule=PathPrefix: /tshare"

networks:
  nuxt:
```
