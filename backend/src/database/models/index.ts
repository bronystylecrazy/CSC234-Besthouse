import House from "@/interface/models/House";
import User from "@/interface/models/User";
import UserProfile from "@/interface/models/UserProfile";
import mongoose from "mongoose";
import { houseSchema, userProfileSchema, userSchema } from "./schema";

export const User = mongoose.model<User>("User", userSchema, "users");
export const House = mongoose.model<House>("House", houseSchema, "houses");
export const Profile = mongoose.model<UserProfile>(
	"Profile",
	userProfileSchema,
	"profiles"
);
