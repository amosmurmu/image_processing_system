import express from "express";
import { checkStatus } from "../controllers/status.controller";

const router = express.Router();

/**
 * @swagger
 * /status/{requestId}:
 *    get:
 *      summary: Tracks the status from requestId
 *      description: returns the status of image products for processing
 *      parameters:
 *        - in: path
 *          name: requestId
 *          required: true
 *          schema:
 *               type: string
 *          description: The unique request ID to track the processing status
 *      responses:
 *        200:
 *          description: Processing Successful
 *        400:
 *          description: Invalid Request ID
 *        404:
 *          description: Request ID not found
 */
router.get("/status/:requestId", checkStatus);

export default router;
