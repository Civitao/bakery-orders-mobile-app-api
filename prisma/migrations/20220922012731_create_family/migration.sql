-- CreateTable
CREATE TABLE "family" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_item" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "price" TEXT NOT NULL,
    "familyId" TEXT,
    CONSTRAINT "item_familyId_fkey" FOREIGN KEY ("familyId") REFERENCES "family" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_item" ("id", "name", "price") SELECT "id", "name", "price" FROM "item";
DROP TABLE "item";
ALTER TABLE "new_item" RENAME TO "item";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
