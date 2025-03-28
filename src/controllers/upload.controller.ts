import { NextFunction, Request, Response } from "express";
import pool from "../services/db";
import * as fs from "fs";
import { parse } from "csv-parse";
import path from "path";
import crypto from "crypto";
import cloudinary from "../services/cloudinary";
import axios from "axios";
import sharp from "sharp";

// Trying upload to cloudinary

const uploadToCloudinary = async (
  buffer: Buffer,
  filename: string
): Promise<string> => {
  const tempFilePath = `./uploads/temp-${filename}.jpg`;
  fs.writeFileSync(tempFilePath, buffer);

  try {
    const uniqueId = `compressed-${Date.now()}`;
    const result = await cloudinary.uploader.upload(tempFilePath, {
      public_id: uniqueId,
      folder: "compressed_images",
      resource_type: "image",
    });
    fs.unlinkSync(tempFilePath);
    return result.secure_url;
  } catch (error) {
    console.error("Cloudinary upload error:", error);
    throw new Error("Failed to upload to Cloudinary");
  }
};

function parseInputImages(input_images: any) {
  if (!input_images.includes("[") && !input_images.includes(",")) {
    return [input_images.trim()];
  } else {
    try {
      return JSON.parse(input_images.replace(/'/g, '"')); // Convert single to double quotes before parsing
    } catch (error) {
      console.error("Invalid input_images format:", input_images, error);
      return []; // Fallback to empty array if parsing fails
    }
  }
}

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
    console.log("File in request", req.file);

    if (!file?.path) {
      res.status(400).json({ error: "No file uploaded" });
      return;
    }

    if (!file?.mimetype.includes("csv")) {
      res.status(400).json({ error: "Invalid file type, only CSV allowed" });
      return;
    }

    const filePath = file?.path;
    fs.createReadStream(filePath)
      .pipe(parse({ columns: true, trim: true }))
      .on("data", (row) => {
        if (!row.product_name || !row.input_images) {
          return next(new Error("Invalid CSV format , missing columns"));
        }
      })
      .on("error", (err) => {
        return next(new Error(`File read error: ${err.message}`));
      });

    const fileBuffer = fs.readFileSync(filePath);
    // console.log(fileBuffer);
    const hash = crypto.createHash("sha256").update(fileBuffer).digest("hex");

    const { rowCount } = await pool.query(
      "SELECT id FROM requests WHERE file_hash = $1",
      [hash]
    );

    if ((rowCount ?? 0) > 0) {
      res.status(400).json({ error: "Duplicate file detected" });
      return;
    }

    const { rows } = await pool.query(
      "INSERT INTO requests (status,file_hash,file_path) VALUES ('PENDING',$1,$2) RETURNING id",
      [hash, filePath]
    );

    const requestId = rows[0].id;

    await createProduct(requestId, filePath);
    res.redirect(`/api/success?requestId=${requestId}`);
  } catch (error) {
    next(error);
  }
};

export const createProduct = async (requestId: string, filePath: string) => {
  try {
    console.log(requestId);

    console.log(filePath);
    const products: { product_name: string; input_images: string[] }[] = [];

    fs.createReadStream(filePath)
      .pipe(parse({ columns: true, trim: true }))
      .on("data", (row) => {
        if (!row.product_name || !row.input_images) {
          throw new Error("Invalid CSV format , missing columns");
        }

        products.push({
          product_name: row.product_name,
          input_images: parseInputImages(row.input_images),
        });
      })
      .on("error", async (error) => {
        console.error(error);
        const reqQuery = "UPDATE requests SET status = $1 WHERE id= $2";
        await pool.query(reqQuery, ["FAILED", requestId]);
        console.log("Status Updated to FAILED");
      })
      .on("end", async () => {
        try {
          const processingQuery =
            "UPDATE requests SET status = $1 WHERE id= $2";
          await pool.query(processingQuery, ["PROCESSING", requestId]);
          console.log("Status Updated to PROCESSING");

          const query =
            "INSERT INTO products (request_id, product_name,input_images, output_images) VALUES ($1,$2,$3,$4)";

          for (const product of products) {
            const outputImages: string[] = [];
            const csvRow = product.input_images;
            const imageUrls = csvRow
              .map((url) => url.trim())
              .filter((url) => url !== "");
            for (const image of imageUrls) {
              try {
                const response = await axios({
                  url: image,
                  responseType: "arraybuffer",
                });

                const compressedBuffer = await sharp(response.data)
                  .jpeg({ quality: 50 })
                  .toBuffer();

                const outputUrl = await uploadToCloudinary(
                  compressedBuffer,
                  `compressed-${Date.now()}`
                );
                outputImages.push(outputUrl);
              } catch (error) {
                console.error(`Error processing image : ${image},`, error);
              }
            }

            await pool.query(query, [
              requestId,
              product.product_name,
              product.input_images,
              outputImages,
            ]);
          }
        } catch (error) {
          console.log("Error processing CSV File");
          return;
        }
        console.log(
          "CSV processed successfully and products added for request",
          requestId
        );

        const reqQuery = "UPDATE requests SET status = $1 WHERE id= $2";
        await pool.query(reqQuery, ["PROCESSED", requestId]);
        console.log("Status Updated to PROCESSED");

        await triggerWebhook(
          requestId,
          "https://webhook.site/ffd59d5f-d778-4f02-ab37-04ad438ca644"
        );
      });
  } catch (error) {
    console.error("Error in createProduct", error);
  }
};

const triggerWebhook = async (requestId: string, webhookUrl: string) => {
  try {
    await axios.post(webhookUrl, {
      requestId: requestId,
      status: "PROCESSED",
    });

    console.log("Webhook successfully triggered");
  } catch (error) {
    console.error("Error triggerring webhook:", error);
  }
};
