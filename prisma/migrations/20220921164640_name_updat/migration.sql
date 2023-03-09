/*
  Warnings:

  - You are about to drop the column `familyName` on the `Family` table. All the data in the column will be lost.
  - Added the required column `name` to the `Family` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Family" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "item" TEXT NOT NULL
);
INSERT INTO "new_Family" ("id", "item") SELECT "id", "item" FROM "Family";
DROP TABLE "Family";
ALTER TABLE "new_Family" RENAME TO "Family";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
