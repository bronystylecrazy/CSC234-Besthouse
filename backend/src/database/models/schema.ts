import { Schema, Types } from "mongoose";
import User from "@/interface/models/User";
import UserProfile from "@/interface/models/Profile";
import House from "@/interface/models/House";
import HouseDetail from "@/interface/models/HouseDetail";

const validateEmail = function (email) {
	var re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	return re.test(email);
};

export enum HouseType {
	condominium = "CONDOMINIUM",
	house = "HOUSE",
	hotel = "HOTEL",
	shophouse = "SHOPHOUSE",
}

export enum RoomType {
	living = "LIVING ROOM",
	bed = "BEDROOM",
	kitchen = "KITCHEN",
	bath = "BATHROOM",
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
		minlength: [4, "Password must be at least 4 characters"],
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
		minLength: [10, "Phone number should be at least 11 characters"],
		maxlength: [10, "Phone number should be at most 11 characters"],
	},
});

export const userProfileSchema = new Schema<UserProfile>({
	user_id: {
		type: Types.ObjectId,
		ref: "User",
		required: [true, "User id is required"],
	},
	firstname: { type: String, required: [true, "Enter a firstname"] },
	lastname: { type: String, required: [true, "Enter a lastname"] },
	line_id: String,
	facebook: String,
	picture_url: String,
});

export const houseSchema = new Schema<House>({
	name: {
		type: String,
		required: [true, "Enter a house name."],
	},
	picture_url: String,
	address: { type: String, required: true },
	location: {
		type: {
			type: String, // Don't do `{ location: { type: String } }`
			enum: ["Point"], // 'location.type' must be 'Point'
			required: true,
		},
		coordinates: {
			type: [Number],
			required: true,
		},
	},
	price: {
		type: Number,
		required: [true, "Price is required"],
		min: [1, "Price should not be less than 0"],
	},
	type: {
		type: String,
		enum: Object.values(HouseType),
		default: HouseType.house,
	},
	status: { type: Boolean, default: true },
	tags: [String],
	isAdvertised: { type: Boolean, default: false },
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
	rooms: {
		type: [
			{
				type: {
					type: String,
					enum: Object.values(RoomType),
					required: [true, "Room type is required"],
				},
				numbers: Number,
				pictures: [String],
			},
		],
		required: [true, "Rooms required"],
		minlength: [1, "At least one room required"],
	},
	description: String,
	facilities: [String],
	electric_fee: Number,
	water_fee: Number,
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
