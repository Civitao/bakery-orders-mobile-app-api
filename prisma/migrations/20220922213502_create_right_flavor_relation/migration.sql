/*
  Warnings:

  - You are about to drop the column `itemId` on the `Flavor` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "ItemsFlavors" (
    "itemId" TEXT,
    "flavorId" TEXT,
    "id" TEXT NOT NULL PRIMARY KEY,
    CONSTRAINT "ItemsFlavors_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "Item" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "ItemsFlavors_flavorId_fkey" FOREIGN KEY ("flavorId") REFERENCES "Flavor" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Flavor" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "available" BOOLEAN NOT NULL DEFAULT true
);
INSERT INTO "new_Flavor" ("available", "id", "name") SELECT "available", "id", "name" FROM "Flavor";
DROP TABLE "Flavor";
ALTER TABLE "new_Flavor" RENAME TO "Flavor";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
