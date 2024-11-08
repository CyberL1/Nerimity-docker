FROM node:lts

WORKDIR /cdn

COPY nerimity-cdn-ts .
COPY entrypoint.sh .
COPY .env .

RUN apt update
RUN apt install imagemagick

RUN npm i -g pnpm
RUN pnpm i

RUN chmod +x entrypoint.sh
ENTRYPOINT ./entrypoint.sh
