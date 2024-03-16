import mongoose from "mongoose";
import User from "./userSchema.js";

const houseSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    unique: true,
  },
  users: [{ type: mongoose.Schema.Types.ObjectId, ref: "User" }],
});

export default mongoose.model("House", houseSchema);
