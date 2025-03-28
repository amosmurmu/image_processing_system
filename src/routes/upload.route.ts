import express from "express";
import multer from "multer";
import { getIndex, createRequest } from "../controllers/upload.controller";
import path from "path";
import { Request, Response } from "express";
const router = express.Router();
const upload = multer({ dest: "uploads/" }); // Save CSVs to "uploads/" folder

/**
 * @swagger
 * /upload:
 *  post:
 *    summary: Upload a CSV File
 *    description: Accepts a single file and processes the request and send requestId
 *    consumes:
 *      - multipart/form-data
 *    parameters:
 *      - in: formData
 *        name: file
 *        type: file
 *        required: true
 *        description: The CSV file to upload
 *    responses:
 *      200:
 *        description: File uploaded successfully
 *      400:
 *        description: Invalid file or request
 */
router.post("/upload", upload.single("file"), createRequest);

/**
 * @swagger
 * /file:
 *    get:
 *      summary: Show the index page
 *      description: shows the html file to upload CSV
 *      responses:
 *        200:
 *          description: Upload the file
 */
router.get("/file", getIndex);

/**
 * @swagger
 * /success:
 *    get:
 *       summary: Success page
 *       description: Returns a success page after file upload
 *       responses:
 *        200:
 *          description: Success page loaded
 */
router.get("/success", (req: Request, res: Response) => {
  res.sendFile(path.join(__dirname, "../views/success.html"));
});
export default router;
