import Prisma, * as PrismaScope from "@prisma/client";

export const { PrismaClient } = Prisma || PrismaScope;
export const prisma = new PrismaClient();
