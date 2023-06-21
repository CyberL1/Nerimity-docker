FROM node:alpine

WORKDIR /client

COPY nerimity-web .

RUN npm i -g pnpm
RUN pnpm i
CMD pnpm dev
