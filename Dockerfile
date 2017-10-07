FROM node:8.6-alpine
MAINTAINER Victor Perin <me@victorperin.ninja>

RUN mkdir /hubot
RUN cd /hubot
WORKDIR /hubot

COPY package.json /hubot/
RUN npm install --only=prod

COPY . /hubot
