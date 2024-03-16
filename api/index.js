import express from "express";
import mongoose from "mongoose";
import cors from "cors";
import User from "./models/userSchema.js";
import House from "./models/houseSchema.js";
import http from "http"; // Import http module
import { Server as socketIO } from "socket.io"; // Import socketIO from socket.io

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

// Create http server instance
const server = http.createServer(app);

// Create socketIO instance using the http server
const io = new socketIO(server);

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
    const userData = res.status(200).json({
      message: "Login successful",
      user: { _id: user._id, name: user.name, email: user.email },
    });
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

app.get("/api/getHouse/:userid", async (req, res) => {
  const userId = req.params.userid; // Retrieve userId from route parameters
  try {
    const userHouses = await House.find({ users: userId });
    if (!userHouses || userHouses.length === 0) {
      return res.status(404).json({ message: "User has no houses" });
    }
    res
      .status(200)
      .json({ message: "User houses fetched successfully", userHouses });
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ error: "An error occurred while querying the database" });
  }
});

app.post("/api/addRoom", async (req, res) => {
  try {
    const { houseId, roomName, devices } = req.body;

    if (!houseId || !roomName || !devices || devices.length === 0) {
      return res
        .status(400)
        .json({ message: "houseId, roomName, and devices are required" });
    }

    const house = await House.findById(houseId);
    if (!house) {
      return res.status(404).json({ message: "House not found" });
    }

    const room = {
      name: roomName,
      devices: devices.map((device) => ({
        name: device.name,
        type: device.type,
      })),
    };

    house.rooms.push(room);

    await house.save();

    res.status(201).json({ message: "Room added successfully", house });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

app.post("/api/addDevicesToRoom", async (req, res) => {
  try {
    const { houseId, roomName, devices } = req.body;

    if (!houseId || !roomName || !devices || devices.length === 0) {
      return res
        .status(400)
        .json({ message: "houseId, roomName, and devices are required" });
    }

    const house = await House.findById(houseId);
    if (!house) {
      return res.status(404).json({ message: "House not found" });
    }

    const room = house.rooms.find((room) => room.name === roomName);
    if (!room) {
      return res.status(404).json({ message: "Room not found" });
    }
    room.devices.push(...devices);
    await house.save();

    res
      .status(200)
      .json({ message: "Devices added to the room successfully", house });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

app.get("/api/getUser/:userId", async (req, res) => {
  const userId = req.params.userId;
  try {
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    res.status(200).json({ message: "User found", user });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

app.post("/setSecurity/:houseId", async (req, res) => {
  const { houseId } = req.params;
  const { securityLevel } = req.body;

  try {
    const house = await House.findById(houseId);
    if (!house) {
      return res.status(404).json({ message: "House not found" });
    }

    if (![0, 1, 2].includes(securityLevel)) {
      return res.status(400).json({ message: "Invalid security level" });
    }

    house.security = securityLevel;
    await house.save();

    return res
      .status(200)
      .json({ message: "Security level updated successfully" });
  } catch (error) {
    console.error("Error setting security level:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
});

//sockets ==================================

io.on("connection", (socket) => {
  console.log("A client connected");
  socket.on("sendSOS", async (houseId) => {
    try {
      const house = await House.findById(houseId);
      if (!house) {
        socket.emit("error", { message: "House not found" });
        return;
      }
      socket.emit("sos", { house });
    } catch (error) {
      console.error("Error sending SOS request:", error);
      socket.emit("error", { message: "Internal server error" });
    }
  });
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
