import { NextFunction, Request, Response } from "express";
import pool from "../services/db";
import * as fs from "fs";
import { parse } from "csv-parse";

export const createRequest = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const filePath = req.file?.path;

    if (!filePath) {
      res.status(400).json({ error: "No file uploaded" });
    }

    const { rows } = await pool.query(
      "INSERT INTO requests (status) VALUES ('PENDING') RETURNING id"
    );

    const requestId = rows[0].id;

    const products: { product_name: string; input_images: string[] }[] = [];

    fs.createReadStream(filePath)
      .pipe(parse({ columns: true, trim: true }))
      .on("data", (row) => {
        products.push({
          product_name: row.product_name,
          input_images: row.input_images.includes(",")
            ? row.input_images.split(",")
            : [row.input_images],
        });
      })
      .on("end", async () => {
        const query =
          "INSERT INTO products (request_id, product_name,input_images, output_images) VALUES ($1,$2,$3,$4)";

        for (const product of products) {
          await pool.query(query, [
            requestId,
            product.product_name,
            product.input_images,
            [],
          ]);
        }

        return res.json({ message: "CSV uploaded successfully", requestId });
      })
      .on("error", (error) => {
        console.error(error);
        res.status(500).json({ error: "Error processing CSV File" });
      });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server error" });
  }
};
