import express from "express";
import mongoose from "mongoose";
import cors from "cors";
import User from "./models/userSchema.js";
import House from "./models/houseSchema.js";

const app = express();
app.use(express.json());
app.use(cors());

const PORT = 3000;

mongoose
  .connect(
    "mongodb+srv://dedsec:w3ghwDIWdJnswIae@cluster0.nc1hi2r.mongodb.net/",
    {
      useNewUrlParser: true,
    }
  )
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((err) => {
    console.log("Error: ", err);
  });

app.post("/api/register", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
      return res.status(400).json({ message: "All fields are required" });
    }
    if (password.length < 6) {
      return res
        .status(400)
        .json({ message: "Password must be at least 6 characters long" });
    }

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ message: "User with this email already exists" });
    }

    const user = new User({ name, email, password });
    const response = await user.save();

    res.status(201).json({ message: "user created", user: response });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

app.post("/api/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res
        .status(400)
        .json({ message: "Email and password are required" });
    }

    const user = await User.findOne({ email });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    if (user.password !== password) {
      return res.status(401).json({ message: "Invalid password" });
    }

    res.status(200).json({ message: "Login successful", user });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

app.post("/api/houses", async (req, res) => {
  try {
    const { name, creatorId } = req.body;

    if (!creatorId) {
      return res.status(400).json({ message: "Creator ID is required" });
    }

    const creator = await User.findById(creatorId);
    if (!creator) {
      return res.status(404).json({ message: "Creator not found" });
    }
    const existingHouse = await House.findOne({ name });
    if (existingHouse) {
      return res.status(400).json({
        message: "The House name is already taken, choose a unique name",
      });
    }
    const house = new House({ name, creator: creatorId, users: [creatorId] });
    await house.save();

    res.status(201).json({ message: "House created successfully", house });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

app.post("/api/joinHouse", async (req, res) => {
  try {
    const { userId, houseName } = req.body;

    if (!userId || !houseName) {
      return res
        .status(400)
        .json({ message: "User ID and house name are required" });
    }

    const house = await House.findOne({ name: houseName });
    if (!house) {
      return res.status(404).json({ message: "House not found" });
    }

    if (house.users.find((user) => user._id.toString() === userId)) {
      return res
        .status(400)
        .json({ message: "User is already a member of the house" });
    }

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    house.users.push({ _id: user._id, name: user.name, email: user.email });
    await house.save();

    res
      .status(200)
      .json({ message: "User joined the house successfully", house });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
