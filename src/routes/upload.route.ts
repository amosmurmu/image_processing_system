import express from "express";
import multer from "multer";
import { getIndex, createRequest } from "../controllers/upload.controller";
import path from "path";

const router = express.Router();
const upload = multer({ dest: "uploads/" }); // Save CSVs to "uploads/" folder

router.post("/upload", upload.single("file"), createRequest);
router.get("/file", getIndex);
router.get("/success", (req, res) => {
  console.log(req.query.requestId);
  // console.log("apple");
  res.sendFile(path.join(__dirname, "../views/success.html"));
});

export default router;
