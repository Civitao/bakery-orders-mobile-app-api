/*
  Warnings:

  - The primary key for the `Family` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Flavor` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `flavorId` on the `Flavor` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - You are about to drop the column `flavor` on the `Item` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Family" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "item" TEXT NOT NULL
);
INSERT INTO "new_Family" ("id", "item", "name") SELECT "id", "item", "name" FROM "Family";
DROP TABLE "Family";
ALTER TABLE "new_Family" RENAME TO "Family";
CREATE TABLE "new_Flavor" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "flavorName" TEXT NOT NULL,
    "flavorId" INTEGER NOT NULL,
    CONSTRAINT "Flavor_flavorId_fkey" FOREIGN KEY ("flavorId") REFERENCES "Item" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Flavor" ("flavorId", "flavorName", "id") SELECT "flavorId", "flavorName", "id" FROM "Flavor";
DROP TABLE "Flavor";
ALTER TABLE "new_Flavor" RENAME TO "Flavor";
CREATE TABLE "new_Item" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "pictureUrl" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "family" TEXT NOT NULL
);
INSERT INTO "new_Item" ("description", "family", "id", "name", "pictureUrl") SELECT "description", "family", "id", "name", "pictureUrl" FROM "Item";
DROP TABLE "Item";
ALTER TABLE "new_Item" RENAME TO "Item";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
