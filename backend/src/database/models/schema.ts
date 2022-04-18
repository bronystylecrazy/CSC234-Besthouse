import { Schema, Types } from "mongoose";
import User from "@/interface/models/User";
import UserProfile from "@/interface/models/UserProfile";
import House from "@/interface/models/House";
import HouseDetail from "@/interface/models/HouseDetail";

const validateEmail = function (email) {
	const re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	return re.test(email);
};

export enum HouseType {
	condominium = "CONDOMINIUM",
	house = "HOUSE",
	hotel = "HOTEL",
	shophouse = "SHOPHOUSE",
}

export enum RoomType {
	living = "LIVING",
	bed = "BED",
	kitchen = "KITCHEN",
	bath = "BATH",
}

export const userSchema = new Schema<User>({
	username: {
		type: String,
		unique: true,
		required: [true, "Enter a username."],
	},
	password: {
		type: String,
		required: [true, "Enter a password."],
	},
	email: {
		type: String,
		required: [true, "Enter an email address."],
		validate: [validateEmail, "Please fill a valid email address"],
		unique: true,
	},
	tel: {
		type: String,
		required: [true, "Enter a phone number."],
		minLength: [11, "Phone number should be at least 11 characters"],
		maxlength: [11, "Phone number should be at most 11 characters"],
	},
});

export const userProfileSchema = new Schema<UserProfile>({
	firstname: { type: String, required: [true, "Enter a firstname"] },
	lastname: { type: String, required: [true, "Enter a lastname"] },
	line_id: String,
	facebook: String,
});

export const houseSchema = new Schema<House>({
	name: {
		type: String,
		required: [true, "Enter a house name."],
	},
	picture_url: String,
	location: {
		type: {
			address: String,
			latitude: String,
			longtitude: String,
		},
		required: [true, "Location required"],
	},
	status: { type: Boolean, default: true },
	tags: [String],
});

export const houseDetailSchema = new Schema<HouseDetail>({
	house_id: {
		type: Types.ObjectId,
		ref: "House",
		required: [true, "House id is required"],
	},
	user_id: {
		type: Types.ObjectId,
		ref: "User",
		required: [true, "User id is required"],
	},
	type: {
		type: String,
		enum: Object.values(HouseType),
		default: HouseType.house,
	},
	rooms: {
		type: [
			{
				type: {
					type: String,
					enum: Object.values(RoomType),
					required: [true, "Room type is required"],
				},
				numbers: Number,
				pictures: [
					{
						url: String,
					},
				],
			},
		],
		required: [true, "Rooms required"],
		minlength: [1, "At least one room required"],
	},
	description: String,
	price: {
		type: Number,
		required: [true, "Price is required"],
		min: [1, "Price should not be less than 0"],
	},
	facilities: [
		{
			name: String,
			checked: Boolean,
		},
	],
	electric_fee: Number,
	likes: { type: Number, default: 0 },
	total_size: { type: Number, required: [true, "Size is required"] },
});

export const favoriteSchema = new Schema({
	house_id: {
		type: Types.ObjectId,
		ref: "House",
		required: [true, "House id is required"],
	},
	user_id: {
		type: Types.ObjectId,
		ref: "User",
		required: [true, "User id is required"],
	},
});
