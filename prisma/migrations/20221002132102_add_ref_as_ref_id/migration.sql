/*
  Warnings:

  - You are about to drop the column `ref` on the `Item` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Item" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "pictureUrl" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "iprice" TEXT,
    "quantity" INTEGER DEFAULT 1,
    "about" TEXT,
    "familyId" INTEGER,
    "refId" TEXT,
    CONSTRAINT "Item_familyId_fkey" FOREIGN KEY ("familyId") REFERENCES "Family" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Item" ("about", "description", "familyId", "id", "iprice", "name", "pictureUrl", "quantity") SELECT "about", "description", "familyId", "id", "iprice", "name", "pictureUrl", "quantity" FROM "Item";
DROP TABLE "Item";
ALTER TABLE "new_Item" RENAME TO "Item";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
