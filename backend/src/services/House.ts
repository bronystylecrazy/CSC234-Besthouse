import { House, HouseDetail, Favorite, User, Profile } from "@/database/models";
import { OfferPatch } from "@/interface/api/OfferType";
import { Types } from "mongoose";
import { FavouritePost } from "@/interface/api/FavoritePost";
import { Request } from "express";
import { Schema } from "mongoose";
import { genericError, infoResponse } from "./Handler";
import { isLogin } from "./Utils";

export const GetOffer = async (req: Request) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}

		const user_id = req.user.user_id;

		// List houses detail by user id
		const houseDetails = await HouseDetail.find(
			{ user_id: user_id },
			"house_id"
		);

		const ids: Schema.Types.ObjectId[] = houseDetails.map(
			(houseDetail) => houseDetail.house_id
		);

		// List houses by id of house detail
		const houses = await House.find(
			{ _id: { $in: ids } },
			"_id status name"
		);
		return infoResponse(houses);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const GetOfferById = async (user_id: String) => {
	try {
		// List houses detail by user id
		const houseDetails = await HouseDetail.find(
			{ user_id: user_id },
			"house_id"
		);

		const ids: Schema.Types.ObjectId[] = houseDetails.map(
			(houseDetail) => houseDetail.house_id
		);

		// List houses by id of house detail
		const houses = await House.find(
			{ _id: { $in: ids } },
			"_id status name"
		);
		return infoResponse(houses);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const GetOfferInfo = async (house_id: Types.ObjectId, req: Request) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;
		const house = await House.findById(house_id);
		const houseDetail = await HouseDetail.findOne({ house_id: house_id });
		const favourite = await Favorite.find({
			house_id: house._id,
			user_id: user_id,
		});
		const landlord = await Profile.findOne(
			{
				user_id: houseDetail.user_id,
			},
			"user_id firstname lastname picture_url"
		);
		const isLike = favourite.length != 0;

		return infoResponse({ house, houseDetail, isLike, landlord });
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const CreateOffer = async (req: Request, body: OfferPatch) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;
		console.log(body.location);

		try {
			const new_house = await House.create({
				name: body.name,
				address: body.address,
				location: body.location, // number array [Long, Lat]
				picture_url: body.picture_url,
				price: body.price,
				tags: body.tags,
				type: body.type.toUpperCase(),
			});
			await HouseDetail.create({
				user_id: user_id,
				house_id: new_house._id,
				description: body.description,
				electric_fee: body.electric_fee,
				water_fee: body.water_fee,
				facilities: body.facilities,
				rooms: body.rooms.map((room) => {
					room.type = room.type.toUpperCase();
					return room;
				}),
				total_size: body.total_size,
			});
		} catch (error) {
			return genericError(error.message, 400);
		}

		return infoResponse(null, "offer added!", 201);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const UpdateOffer = async (
	house_id: Types.ObjectId,
	body: OfferPatch,
	req: Request
) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;

		// check permission
		const houseDetail = await HouseDetail.findOne({
			user_id: user_id,
			house_id: house_id,
		}).exec();

		if (houseDetail == null) {
			return genericError("Unauthorize: User is not own this offer", 400);
		}

		// update house and houseDetail
		try {
			await House.updateOne(
				{ _id: house_id },
				{
					$set: {
						name: body.name,
						address: body.address,
						location: body.location, // number array [Long, Lat]
						picture_url: body.picture_url,
						price: body.price,
						tags: body.tags,
						type: body.type.toUpperCase(),
					},
				}
			).exec();
			await houseDetail
				.updateOne({
					$set: {
						description: body.description,
						electric_fee: body.electric_fee,
						water_fee: body.water_fee,
						facilities: body.facilities,
						rooms: body.rooms.map((room) => {
							room.type = room.type.toUpperCase();
							return room;
						}),
						total_size: body.total_size,
					},
				})
				.exec();
		} catch (error) {
			return genericError(error.message, 400);
		}

		return infoResponse(null, "offer edited");
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const DeleteOffer = async (house_id: Types.ObjectId, req: Request) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;

		await HouseDetail.findOneAndDelete({
			user_id: user_id,
			house_id: house_id,
		}).exec();
		await House.findByIdAndRemove(house_id).exec();

		return infoResponse(null, "offer deleted!");
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const ListFavoriteHouse = async (req: Request) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}

		const user_id = req.user.user_id;

		// Fetch favorite list from userid
		const housesId = await Favorite.find(
			{ user_id: user_id },
			"house_id"
		).exec();
		const ids: Schema.Types.ObjectId[] = housesId.map((e) => e.house_id);

		// Fetch houses from favourite
		const houses = await House.find({ _id: { $in: ids } }).exec();
		return infoResponse(houses);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const FavoriteHouse = async (body: FavouritePost, req: Request) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}

		const user_id = req.user.user_id;

		// check if the user favorited or not
		var favorite = await Favorite.findOne({
			house_id: body.house_id,
			user_id: user_id,
		});
		var house = await HouseDetail.findOne({
			house_id: body.house_id,
		}).exec();
		if (favorite) {
			await favorite.remove();
			await house.updateOne({ $set: { likes: house.likes - 1 } });
			return infoResponse(null, "Removed from favorite");
		}

		await house.updateOne({ $set: { likes: house.likes + 1 } });

		await new Favorite({
			house_id: body.house_id,
			user_id: user_id,
		}).save();
		return infoResponse(null, "Added to favorite!");
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const ToggleAvailable = async (house_id: any, req: Request) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;

		const id = new Types.ObjectId(house_id);
		// check permission
		const houseDetail = await HouseDetail.findOne({
			user_id: user_id,
			house_id: id,
		}).exec();

		if (houseDetail == null) {
			return genericError("Unauthorize: User is not own this offer", 400);
		}

		// update house
		const house = await House.findById(id).exec();
		await house.updateOne({ $set: { status: !house.status } });
		return infoResponse(null, "Offer updated!");
	} catch (error) {
		return genericError(error.message, 500);
	}
};
