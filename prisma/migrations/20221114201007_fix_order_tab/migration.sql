/*
  Warnings:

  - You are about to drop the column `orderId` on the `Item` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Cart" (
    "id" TEXT,
    "name" TEXT NOT NULL,
    "pictureUrl" TEXT NOT NULL,
    "flavor" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "price" INTEGER NOT NULL,
    "unitId" TEXT NOT NULL PRIMARY KEY,
    "orderId" INTEGER,
    CONSTRAINT "Cart_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "Order" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Cart" ("flavor", "id", "name", "pictureUrl", "price", "quantity", "unitId") SELECT "flavor", "id", "name", "pictureUrl", "price", "quantity", "unitId" FROM "Cart";
DROP TABLE "Cart";
ALTER TABLE "new_Cart" RENAME TO "Cart";
CREATE TABLE "new_Item" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "pictureUrl" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "iprice" TEXT,
    "quantity" INTEGER DEFAULT 1,
    "about" TEXT,
    "cost" INTEGER,
    "refId" TEXT,
    "familyId" TEXT,
    CONSTRAINT "Item_familyId_fkey" FOREIGN KEY ("familyId") REFERENCES "Family" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Item" ("about", "cost", "description", "familyId", "id", "iprice", "name", "pictureUrl", "quantity", "refId") SELECT "about", "cost", "description", "familyId", "id", "iprice", "name", "pictureUrl", "quantity", "refId" FROM "Item";
DROP TABLE "Item";
ALTER TABLE "new_Item" RENAME TO "Item";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
