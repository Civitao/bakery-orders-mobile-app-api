/*
  Warnings:

  - You are about to drop the column `itemId` on the `price` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_price" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "price" TEXT NOT NULL,
    "familyId" TEXT,
    CONSTRAINT "price_familyId_fkey" FOREIGN KEY ("familyId") REFERENCES "family" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_price" ("familyId", "id", "price") SELECT "familyId", "id", "price" FROM "price";
DROP TABLE "price";
ALTER TABLE "new_price" RENAME TO "price";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
