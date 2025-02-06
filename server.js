// server.js
require("dotenv").config();
const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const { errorHandler } = require("./middleware/errorMiddleware");

// The main router
const apiRouter = require("./routes/index");

const app = express();

// Global middleware
app.use(cors({ origin: "*" }));
app.use(bodyParser.json());

// Routes
app.use("/", apiRouter);

// Optional: global error handler
app.use(errorHandler);

module.exports = app;
