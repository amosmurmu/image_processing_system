import express, { Request, Response, NextFunction } from "express";
import path from "path";
import { setupSwagger } from "./swagger";
import uploadRoutes from "./routes/upload.route";
import statusRoutes from "./routes/status.route";
const app = express();

const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  // console.log("apple" ,__dirname);
  res.sendFile(path.join(__dirname,"../public/index.html"));
});

app.use(express.json()); // Middleware to parse JSON
app.use(express.static(path.join(__dirname,'../public'))); // Serve static files
app.use("/api", uploadRoutes);
app.use("/api", statusRoutes);
setupSwagger(app);
app.use((err: any, req: Request, res: Response, next: NextFunction) => {
  console.error(err);
  res.status(err.status || 500).json({
    message: err.message || "Internal Server Error",
  });
});

app.listen(PORT, () => {
  console.log(`Server running on  `, { PORT });
  console.log(`Swagger docs available at http://localhost:${PORT}/api-docs`);
});
