FROM node:alpine

WORKDIR /cdn
COPY nerimity-cdn .

RUN apk add imagemagick

RUN npm i
CMD npm start
