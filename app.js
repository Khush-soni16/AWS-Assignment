const express = require("express");
const mongoose = require("mongoose");

const app = express();
const PORT = 3000;

// Middleware
app.use(express.json());

// MongoDB connection (dummy URI for now)
const mongoURI = "mongodb://localhost:27017/testdb";
mongoose.connect(mongoURI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log("MongoDB connected"))
  .catch(err => console.log("MongoDB connection error:", err));

// Basic route
app.get("/", (req, res) => {
    res.send("Hello from DevSecOps Assignment!");
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
