import { NextFunction, Request, Response } from "express";
import pool from "../services/db";
import * as fs from "fs";
import { parse } from "csv-parse";
import path from "path";

export const getIndex = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  res.sendFile(path.join(__dirname, "../views/index.html"));
};

export const createRequest = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const file = req.file;
    console.log("Request Body:", req.body);

    if (!file?.path) {
      res.status(400).json({ error: "No file uploaded" });
      return;
    }

    if (!file?.mimetype.includes("csv")) {
      res.status(400).json({ error: "Invalid file type, only CSV allowed" });
    }

    const filePath = file?.path;

    fs.createReadStream(filePath)
      .pipe(parse({ columns: true, trim: true }))
      .on("data", (row) => {
        if (!row.product_name || !row.input_images) {
          res
            .status(400)
            .json({ error: "Invalid CSV format, missing columns" });
        }
      });

    const { rows } = await pool.query(
      "INSERT INTO requests (status) VALUES ('PENDING') RETURNING id"
    );

    const requestId = rows[0].id;

    res.redirect(`/api/success?requestId=${requestId}`);
  } catch (error) {
    next(error);
  }
};

export const createProduct = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const file = req.file;
    const requestId = req.query.requestId;
    console.log("Request Body:", req.body);
    console.log(file);

    if (!requestId) {
      return res.status(400).json({ error: "Request ID is required" });
    }
    if (!file?.path) {
      res.status(400).json({ error: "No file uploaded" });
      return;
    }

    const filePath = file?.path;

    const products: { product_name: string; input_images: string[] }[] = [];

    fs.createReadStream(filePath)
      .pipe(parse({ columns: true, trim: true }))
      .on("data", (row) => {
        if (!row.product_name || !row.input_images) {
          res
            .status(400)
            .json({ error: "Invalid CSV format, missing columns" });
        }

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
        console.log("Uploaded file:", req.file); // Verify file exists
        res.json({ message: "CSV uploaded successfully", requestId });
      })
      .on("error", (error) => {
        console.error(error);
        res.status(500).json({ error: "Error processing CSV File" });
      });
  } catch (error) {
    next(error);
  }
};
