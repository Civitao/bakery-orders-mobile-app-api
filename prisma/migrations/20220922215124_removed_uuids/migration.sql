/*
  Warnings:

  - You are about to drop the `ItemsFlavors` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "ItemsFlavors";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "_FlavorToItem" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_FlavorToItem_A_fkey" FOREIGN KEY ("A") REFERENCES "Flavor" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_FlavorToItem_B_fkey" FOREIGN KEY ("B") REFERENCES "Item" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "_FlavorToItem_AB_unique" ON "_FlavorToItem"("A", "B");

-- CreateIndex
CREATE INDEX "_FlavorToItem_B_index" ON "_FlavorToItem"("B");
