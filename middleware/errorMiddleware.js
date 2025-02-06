// middleware/errorMiddleware.js

function errorHandler(err, req, res, next) {
  console.error("Global error handler caught an error:", err);
  const statusCode = err.statusCode || 500;
  const message = err.message || "Server error";
  res.status(statusCode).json({ error: message });
}

module.exports = {
  errorHandler,
};
