/*
  Warnings:

  - You are about to drop the column `flavorId` on the `item` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_item" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL
);
INSERT INTO "new_item" ("id", "name") SELECT "id", "name" FROM "item";
DROP TABLE "item";
ALTER TABLE "new_item" RENAME TO "item";
CREATE TABLE "new_flavor" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "available" BOOLEAN NOT NULL,
    "itemId" TEXT,
    CONSTRAINT "flavor_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "item" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_flavor" ("available", "id", "name") SELECT "available", "id", "name" FROM "flavor";
DROP TABLE "flavor";
ALTER TABLE "new_flavor" RENAME TO "flavor";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
