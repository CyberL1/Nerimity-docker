FROM node:alpine

WORKDIR /server

COPY nerimity-server .
COPY entrypoint.sh .

ENV PNPM_HOME=/usr/local/bin

RUN npm i -g pnpm && \
  pnpm add -g nodemon && \
  pnpm i && \
  pnpm prisma generate

# Fix for bcrypt
RUN pnpm add bcrypt@6.0.0

RUN chmod +x entrypoint.sh
ENTRYPOINT ./entrypoint.sh
