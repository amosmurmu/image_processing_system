declare namespace Express {
  export interface Request {
    file?: Express.Multer.File; // Multer ki file type
  }
}
