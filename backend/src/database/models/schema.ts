import { Schema, Types } from "mongoose";
import User from "@/interface/models/User";
import UserProfile from "@/interface/models/UserProfile";
import House from "@/interface/models/House";
import HouseDetail from "@/interface/models/HouseDetail";

enum HouseType {
	condominium,
	house,
	hotel,
	shophouse,
}

enum RoomType {
	living,
	bed,
	kitchen,
	bath,
}

export const userSchema = new Schema<User>({
	username: String, // String is shorthand for {type: String}
	password: String,
	email: String,
	tel: String,
});

export const userProfileSchema = new Schema<UserProfile>({
	firstname: String,
	lastname: String,
	line_id: String,
	facebook: String,
});

// const User = model<User>("User", userSchema);

export const houseSchema = new Schema<House>({
	name: String,
	picture_url: String,
	location: {
		address: String,
		latitude: String,
		longtitude: String,
	},
	status: Boolean,
	tags: [String],
});

export const houseDetailSchema = new Schema<HouseDetail>({
	house_id: { type: Types.ObjectId, ref: "House" },
	user_id: { type: Types.ObjectId, ref: "User" },
	type: String,
	rooms: [
		{
			type: String,
			numbers: Number,
			pictures: [
				{
					url: String,
				},
			],
		},
	],
	description: String,
	price: String,
	facilities: [
		{
			name: String,
			checked: Boolean,
		},
	],
	electric_fee: Number,
	likes: Number,
	total_size: Number,
});

export const favoriteSchema = new Schema({
	house_id: { type: Types.ObjectId, ref: "House" },
	user_id: { type: Types.ObjectId, ref: "User" },
});
