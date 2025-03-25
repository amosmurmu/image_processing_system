import express from "express";

import uploadRoutes from "./routes/upload.route";

const app = express();

const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.send("Hello world");
});
app.use(express.json()); // Middleware to parse JSON
app.use("/api", uploadRoutes);

app.listen(PORT, () => {
  console.log(`Server running on  `, { PORT });
});
