import express from "express";
import multer from "multer";
import { createRequest } from "../controllers/upload.controller";

const router = express.Router();
const upload = multer({ dest: "uploads/" }); // Save CSVs to "uploads/" folder

router.post("/upload", upload.single("file"), createRequest);

export default router;
