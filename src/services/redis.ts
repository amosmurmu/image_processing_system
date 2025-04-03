import { Queue, Worker } from "bullmq";
import Redis from "ioredis";
import { createProduct } from "../controllers/upload.controller";

const redis = new Redis({
  host: "real-hen-53452.upstash.io",
  port: 6379,
  username: "default",
  password: "AdDMAAIjcDE1YjQ2N2MxMjk3MWM0NzgwODM1NDdiYjNhZmQxZDcxYnAxMA",
  tls: {},
  maxRetriesPerRequest: null,
});

redis.on("connect", () => {
  console.log("Connected to Upstash Redis");
});
redis.on("error", (err) => {
  console.error("Redis Error:", err);
});

export const productQueue = new Queue("productQueue", {
  connection: redis,
});

export const productWorker = new Worker(
  "productQueue",
  async (job) => {
    console.log(`Processing job : ${job.id}`);

    const { requestId, filePath } = job.data;
    await createProduct(requestId, filePath);
  },
  {
    connection: redis,
  }
);

productWorker.on("completed", (job) => {
  console.log(`✅ Job ${job.id} completed!`);
});

productWorker.on("failed", (job, err) => {
  console.log(`❌ Job ${job?.id} failed: ${err.message}`);
});

export default redis;
