FROM node:8.11.2-onbuild
MAINTAINER Clark Wang <clark@bitkan.com>

WORKDIR /usr/src/app

# Copy projects
ONBUILD COPY . /usr/src/app

# Install deps
ONBUILD RUN yarn install
ONBUILD RUN yarn cache clean

# Build
ONBUILD RUN yarn run build

ENV HOST 0.0.0.0
EXPOSE 3000

CMD [ "yarn", "start" ]
