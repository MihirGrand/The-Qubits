import mongoose from "mongoose";
import User from "./userSchema.js";

const houseSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    unique: true,
  },
  security: {
    type: Number,
    required: true,
  },
  users: [{ type: mongoose.Schema.Types.ObjectId, ref: "User" }],
  rooms: [
    {
      _id: false,
      name: { type: String },
      devices: [
        {
          _id: false,
          name: { type: String, unique: true },
          type: { type: Number },
        },
      ],
    },
  ],
});

export default mongoose.model("House", houseSchema);
