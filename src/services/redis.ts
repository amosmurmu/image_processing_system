import Redis from "ioredis";

const redis = new Redis({
  host: "real-hen-53452.upstash.io",
  port: 6379,
  username: "default",
  password: "AdDMAAIjcDE1YjQ2N2MxMjk3MWM0NzgwODM1NDdiYjNhZmQxZDcxYnAxMA",
  tls: {},
});

redis.on("connect", () => {
  console.log("Connected to Upstash Redis");
});
redis.on("error", (err) => {
  console.error("Redis Error:", err);
});
export default redis;
