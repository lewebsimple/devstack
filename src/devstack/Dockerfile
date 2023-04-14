### Base
FROM node:19-alpine as base
LABEL maintainer "Pascal Martineau <pascal@websimple.com>"

WORKDIR /app
RUN apk add --no-cache bash
RUN npm i -g pnpm

### Dependencies
FROM base AS dependencies

COPY package.json pnpm-lock.yaml .npmrc ./
COPY server/prisma/schema.prisma ./server/prisma/
RUN pnpm install

### Build
FROM base AS build

COPY . .
COPY --from=dependencies /app/.nuxt ./.nuxt
COPY --from=dependencies /app/node_modules ./node_modules
RUN pnpm build
RUN pnpm prune --prod --config.ignore-scripts=true

### Deploy
FROM base AS deploy

COPY --from=build /app/.output/ ./.output/
COPY --from=build /app/node_modules/ ./node_modules/
COPY docker-entrypoint.sh package.json ./
COPY server/prisma/ ./server/prisma/

ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

EXPOSE 3000

CMD ["/app/docker-entrypoint.sh"]
