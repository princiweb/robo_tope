FROM node:8.6-alpine
MAINTAINER Victor Perin <me@victorperin.ninja>

RUN mkdir /tope
RUN cd /tope
WORKDIR /tope

RUN ls
COPY package.json /tope/package.json
RUN npm install

COPY . /tope
