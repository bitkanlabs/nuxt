FROM node:8.11.2-alpine
MAINTAINER Clark Wang <clark@bitkan.com>

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN yarn config set registry https://registry.npm.taobao.org

ONBUILD ARG NODE_ENV
ONBUILD ENV NODE_ENV $NODE_ENV
ONBUILD COPY package.json yarn.lock nuxt.config.js /usr/src/app/
ONBUILD COPY .nuxt /usr/src/app/.nuxt
ONBUILD RUN yarn install --non-interactive --prod && yarn cache clean

# ONBUILD RUN yarn run build

ENV HOST 0.0.0.0
EXPOSE 3000

CMD [ "yarn", "start" ]
