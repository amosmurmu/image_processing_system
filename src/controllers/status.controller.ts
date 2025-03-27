import pool from "../services/db";
import { Request, Response } from "express";

export const checkStatus = async (
  req: Request,
  res: Response
): Promise<void> => {
  try {
    const requestId = req.params.requestId;

    if (!requestId) {
      res.status(400).json({ error: "Request ID is required" });
      return;
    }

    const query = "SELECT status FROM requests WHERE id = $1";
    const result = await pool.query(query, [requestId]);

    if (result.rows.length === 0) {
      res.status(404).json({ error: "No request ID in database" });
      return;
    }

    const status = result.rows[0].status;

    let products = [];
    if (status === "PROCESSED") {
      const productQuery = "SELECT * FROM products WHERE request_id = $1";
      const productResult = await pool.query(productQuery, [requestId]);
      products = productResult.rows;
    }

    res.json({ status, products });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};
