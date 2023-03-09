/*
  Warnings:

  - You are about to alter the column `A` on the `_FlavorToItem` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - You are about to alter the column `B` on the `_FlavorToItem` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - The primary key for the `Flavor` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Flavor` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - The primary key for the `Item` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Item` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new__FlavorToItem" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_FlavorToItem_A_fkey" FOREIGN KEY ("A") REFERENCES "Flavor" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_FlavorToItem_B_fkey" FOREIGN KEY ("B") REFERENCES "Item" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new__FlavorToItem" ("A", "B") SELECT "A", "B" FROM "_FlavorToItem";
DROP TABLE "_FlavorToItem";
ALTER TABLE "new__FlavorToItem" RENAME TO "_FlavorToItem";
CREATE UNIQUE INDEX "_FlavorToItem_AB_unique" ON "_FlavorToItem"("A", "B");
CREATE INDEX "_FlavorToItem_B_index" ON "_FlavorToItem"("B");
CREATE TABLE "new_Flavor" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "available" BOOLEAN NOT NULL DEFAULT true
);
INSERT INTO "new_Flavor" ("available", "id", "name") SELECT "available", "id", "name" FROM "Flavor";
DROP TABLE "Flavor";
ALTER TABLE "new_Flavor" RENAME TO "Flavor";
CREATE TABLE "new_Item" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "pictureUrl" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "iprice" TEXT,
    "quantity" INTEGER DEFAULT 1,
    "familyId" TEXT,
    CONSTRAINT "Item_familyId_fkey" FOREIGN KEY ("familyId") REFERENCES "Family" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Item" ("description", "familyId", "id", "iprice", "name", "pictureUrl", "quantity") SELECT "description", "familyId", "id", "iprice", "name", "pictureUrl", "quantity" FROM "Item";
DROP TABLE "Item";
ALTER TABLE "new_Item" RENAME TO "Item";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
