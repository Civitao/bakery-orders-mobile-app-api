/*
  Warnings:

  - You are about to drop the column `price` on the `item` table. All the data in the column will be lost.
  - Added the required column `description` to the `item` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pictureUrl` to the `item` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_price" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "price" TEXT NOT NULL,
    "familyId" TEXT,
    "itemId" TEXT,
    CONSTRAINT "price_familyId_fkey" FOREIGN KEY ("familyId") REFERENCES "family" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "price_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "item" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_price" ("id", "price") SELECT "id", "price" FROM "price";
DROP TABLE "price";
ALTER TABLE "new_price" RENAME TO "price";
CREATE TABLE "new_item" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "pictureUrl" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "familyId" TEXT,
    CONSTRAINT "item_familyId_fkey" FOREIGN KEY ("familyId") REFERENCES "family" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_item" ("familyId", "id", "name") SELECT "familyId", "id", "name" FROM "item";
DROP TABLE "item";
ALTER TABLE "new_item" RENAME TO "item";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
