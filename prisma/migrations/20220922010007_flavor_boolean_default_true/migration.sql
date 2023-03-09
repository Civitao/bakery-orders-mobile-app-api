-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_flavor" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "available" BOOLEAN NOT NULL DEFAULT true,
    "itemId" TEXT,
    CONSTRAINT "flavor_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "item" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_flavor" ("available", "id", "itemId", "name") SELECT "available", "id", "itemId", "name" FROM "flavor";
DROP TABLE "flavor";
ALTER TABLE "new_flavor" RENAME TO "flavor";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
