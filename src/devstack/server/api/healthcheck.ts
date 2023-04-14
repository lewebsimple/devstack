import { prisma } from "@/server/prisma/client";

export default defineEventHandler(async () => {
  const users = await prisma.user.findMany();
  return { users };
});
