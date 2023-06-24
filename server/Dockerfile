FROM node:alpine

WORKDIR /server

COPY nerimity-server .
COPY entrypoint.sh .

ENV PNPM_HOME=/usr/local/bin

RUN npm i -g pnpm
RUN pnpm add -g nodemon
RUN pnpm i
CMD ./entrypoint.sh
