-- RedefineTables
PRAGMA foreign_keys=OFF;
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
