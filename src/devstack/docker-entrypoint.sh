#!/bin/bash

pnpm prisma migrate deploy

exec node .output/server/index.mjs
