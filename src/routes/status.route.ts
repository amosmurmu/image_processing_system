import express from "express";
import { checkStatus } from "../controllers/status.controller";

const router = express.Router();

router.get("/status/:requestId", checkStatus);

export default router;
