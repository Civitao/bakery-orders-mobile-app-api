/*
  Warnings:

  - You are about to drop the `Price` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_FlavorToItem` table. If the table is not empty, all the data it contains will be lost.
  - You are about to alter the column `familyId` on the `Item` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - The primary key for the `Family` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Family` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.

*/
-- DropIndex
DROP INDEX "_FlavorToItem_B_index";

-- DropIndex
DROP INDEX "_FlavorToItem_AB_unique";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Price";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_FlavorToItem";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Item" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "pictureUrl" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "iprice" TEXT,
    "quantity" INTEGER DEFAULT 1,
    "familyId" INTEGER,
    CONSTRAINT "Item_familyId_fkey" FOREIGN KEY ("familyId") REFERENCES "Family" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Item" ("description", "familyId", "id", "iprice", "name", "pictureUrl", "quantity") SELECT "description", "familyId", "id", "iprice", "name", "pictureUrl", "quantity" FROM "Item";
DROP TABLE "Item";
ALTER TABLE "new_Item" RENAME TO "Item";
CREATE TABLE "new_Family" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL
);
INSERT INTO "new_Family" ("id", "name") SELECT "id", "name" FROM "Family";
DROP TABLE "Family";
ALTER TABLE "new_Family" RENAME TO "Family";
CREATE TABLE "new_Flavor" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "available" BOOLEAN NOT NULL DEFAULT true,
    "itemId" INTEGER,
    CONSTRAINT "Flavor_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "Item" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Flavor" ("available", "id", "name") SELECT "available", "id", "name" FROM "Flavor";
DROP TABLE "Flavor";
ALTER TABLE "new_Flavor" RENAME TO "Flavor";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
