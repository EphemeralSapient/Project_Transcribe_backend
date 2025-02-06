// config/config.js
require("dotenv").config();

module.exports = {
  PORT: process.env.PORT || 4949,
  JWT_SECRET: process.env.JWT_SECRET || "SUPER_SECRET_JWT_KEY",

  // DB config
  DB_USER: process.env.DB_USER || "postgres",
  DB_HOST: process.env.DB_HOST || "localhost",
  DB_NAME: process.env.DB_NAME || "testing_project",
  DB_PASS: process.env.DB_PASS || "postgres",
  DB_PORT: process.env.DB_PORT || 5432,

  // HuggingFace & Gemini tokens
  HUGGING_FACE_TOKEN: process.env.HUGGING_FACE_TOKEN,
  GEMINI_API_KEY: process.env.GEMINI_API_KEY,

};
