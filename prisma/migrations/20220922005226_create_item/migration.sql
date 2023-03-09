-- CreateTable
CREATE TABLE "item" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "flavorId" TEXT NOT NULL,
    CONSTRAINT "item_flavorId_fkey" FOREIGN KEY ("flavorId") REFERENCES "flavor" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
