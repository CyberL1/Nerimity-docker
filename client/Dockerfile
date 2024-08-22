FROM node:alpine

ARG VITE_APP_VERSION
ENV VITE_APP_VERSION=$VITE_APP_VERSION

WORKDIR /client

COPY nerimity-web .

RUN npm i -g pnpm
RUN pnpm i
CMD pnpm dev
