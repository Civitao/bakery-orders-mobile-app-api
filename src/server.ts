import express from "express";
import cors from "cors";
import { PrismaClient } from "@prisma/client";
import { sumPrice } from "./utils/sum-price";


const app = express();

app.use(express.json());
app.use(cors());

const prisma = new PrismaClient({
  log: ["query"],
});

app.get("/families", async (request, response) => {
  const families = await prisma.family.findMany({
    select: {
      id: true,
      name: true,
      iconName: true,
      ref: true,
      items: true,
    },
  });
  return response.json(families);
});

app.get("/families/:id/items", async (request, response) => {
  const familyId = request.params.id;

  const items = await prisma.item.findMany({
    select: {
      id: true,
      pictureUrl: true,
      name: true,
      description: true,
      iprice: true,
      about: true,
      Family: true,
      flavors: true,
      quantity: true,
      cost: true,
    },
    where: {
      familyId,
    },
    orderBy: {
      name: "desc",
    },
  });
  return response.json(
    items.map((item) => {
      return {
        ...item,
        // cost: convertThousandToPrice(item.cost)
      };
    })
  );
});

app.get("/items", async (request, response) => {
  const items = await prisma.item.findMany({
    select: {
      id: true,
      pictureUrl: true,
      name: true,
      iprice: true,
      cost: true,
      flavors: true,
      description: true,
      about: true,
      quantity: true,
    },
    orderBy: {
      name: "asc",
    },
  });
  return response.json(
    items.map((item) => {
      return {
        ...item,
      };
    })
  );
});

app.get("/populars", async (request, response) => {
  const populars = await prisma.popular.findMany({
    select: {
      id: true,
      name: true,
      pictureUrl: true,
      iprice: true,
      description: true,
      about: true,
    },
  });
  return response.json(populars);
});

app.get("/items/:id/flavors", async (request, response) => {
  const itemId = request.params.id;

  const flavors = await prisma.flavor.findMany({
    select: {
      id: true,
      name: true,
      available: true,
    },
    where: {
      itemId,
    },
    orderBy: {
      name: "desc",
    },
  });
  return response.json(
    flavors.map((flavors) => {
      return {
        ...flavors,
      };
    })
  );
});

app.get("/cartItems", async (request, response) => {
  const cartItems = await prisma.cart.findMany({
    select: {
      name: true,
      pictureUrl: true,
      flavor: true,
      price: true,
      quantity: true,
      unitId: true,
    },
  });
  return response.json(
    cartItems.map((cart) => {
      return {
        ...cart,
        price: sumPrice(cart.quantity, cart.price),
      };
    })
  );
});

app.get("/orders", async (request, response) => {
  const orders = await prisma.order.findMany({
    select: {
      id: true,
      date: true,
      items: true,
      totalCost: true,
    },
  });

  return response.json(
    orders.map((order) => {
      return {
        ...order,
      };
    })
  );
});

app.post("/orders", async (request, response) => {
  const { id, items, totalCost, date } = request.body;

  const orders = await prisma.order.create({
    data: {
      id,
      items,
      totalCost,
      date,
    },
  });

  return response.json(orders);
});

app.post("/cartItems", async (request, response) => {
  const body: any = request.body;

  const cartItems = await prisma.cart.create({
    data: {
      name: body.name,
      pictureUrl: body.pictureUrl,
      flavor: body.flavor,
      price: body.price,
      quantity: body.quantity,
      unitId: body.unitId,
    },
  });
  return response.json(cartItems);
});

app.delete("/cartItems/:unitId", async (request, response) => {
  const unitId = request.params.unitId;
  const cartItems = await prisma.cart.delete({
    where: {
      unitId,
    },
  });
  return response.json(cartItems);
});

app.delete("/cartItems", async (request, response) => {
  const cartItems = await prisma.cart.deleteMany();
  return response.json(cartItems);
});

app.listen(5554);
