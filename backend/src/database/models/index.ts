import Favorite from "@/interface/models/Favorite";
import House from "@/interface/models/House";
import User from "@/interface/models/User";
import UserProfile from "@/interface/models/UserProfile";
import mongoose from "mongoose";

import { favoriteSchema, houseSchema, userSchema } from "./schema";

export const User = mongoose.model<User>("User", userSchema, "users");
export const House = mongoose.model<House>("House", houseSchema, "houses");
export const Favorite = mongoose.model<Favorite>(
	"Favorite",
	favoriteSchema,
	"favorite"
);
export const Profile = mongoose.model<UserProfile>(
	"Profile",
	userProfileSchema,
	"profiles"
);
