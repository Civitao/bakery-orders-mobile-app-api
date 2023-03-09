/*
  Warnings:

  - You are about to drop the column `orderId` on the `Cart` table. All the data in the column will be lost.
  - Added the required column `Items` to the `Order` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Order" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "Items" TEXT NOT NULL,
    "totalCost" INTEGER,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Order" ("date", "id", "totalCost") SELECT "date", "id", "totalCost" FROM "Order";
DROP TABLE "Order";
ALTER TABLE "new_Order" RENAME TO "Order";
CREATE TABLE "new_Cart" (
    "id" TEXT,
    "name" TEXT NOT NULL,
    "pictureUrl" TEXT NOT NULL,
    "flavor" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "price" INTEGER NOT NULL,
    "unitId" TEXT NOT NULL PRIMARY KEY
);
INSERT INTO "new_Cart" ("flavor", "id", "name", "pictureUrl", "price", "quantity", "unitId") SELECT "flavor", "id", "name", "pictureUrl", "price", "quantity", "unitId" FROM "Cart";
DROP TABLE "Cart";
ALTER TABLE "new_Cart" RENAME TO "Cart";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
