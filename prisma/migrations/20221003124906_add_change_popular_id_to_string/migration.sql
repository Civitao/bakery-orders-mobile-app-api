/*
  Warnings:

  - The primary key for the `Popular` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Popular" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "pictureUrl" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "iprice" TEXT,
    "about" TEXT NOT NULL
);
INSERT INTO "new_Popular" ("about", "description", "id", "iprice", "name", "pictureUrl") SELECT "about", "description", "id", "iprice", "name", "pictureUrl" FROM "Popular";
DROP TABLE "Popular";
ALTER TABLE "new_Popular" RENAME TO "Popular";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
