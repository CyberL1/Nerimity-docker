FROM node:lts

WORKDIR /cdn

COPY nerimity-cdn-ts .
COPY entrypoint.sh .
COPY .env .

RUN apt update && \
  apt install imagemagick

RUN npm i -g pnpm && \
  pnpm i && \
  pnpm prisma generate

RUN chmod +x entrypoint.sh
ENTRYPOINT ./entrypoint.sh
