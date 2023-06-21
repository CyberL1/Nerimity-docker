FROM node:alpine

WORKDIR /server

COPY nerimity-server .
COPY entrypoint.sh .

RUN npm i -g pnpm
RUN npm i -g nodemon
RUN pnpm i
CMD ./entrypoint.sh
