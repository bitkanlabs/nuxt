FROM node:8.11.2
MAINTAINER Clark Wang <clark@bitkan.com>

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN yarn config set registry https://registry.npm.taobao.org

ONBUILD ARG NODE_ENV
ONBUILD ENV NODE_ENV $NODE_ENV
ONBUILD COPY package.json yarn.lock /usr/src/app/
ONBUILD RUN yarn install --non-interactive && yarn cache clean
ONBUILD COPY . /usr/src/app

ONBUILD RUN yarn run build

ENV HOST 0.0.0.0
EXPOSE 3000

CMD [ "yarn", "start" ]
