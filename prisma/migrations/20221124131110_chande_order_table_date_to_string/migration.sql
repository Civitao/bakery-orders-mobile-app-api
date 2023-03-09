-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Order" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "items" TEXT,
    "totalCost" INTEGER,
    "date" TEXT NOT NULL
);
INSERT INTO "new_Order" ("date", "id", "items", "totalCost") SELECT "date", "id", "items", "totalCost" FROM "Order";
DROP TABLE "Order";
ALTER TABLE "new_Order" RENAME TO "Order";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
