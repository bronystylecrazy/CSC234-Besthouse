import express from "express";
import { Favorite, House } from "@/database/models/index";
import { Types, Schema } from "mongoose";
import { getcookie } from "@/utils";
import { FavouritePost } from "@/interface/api/FavoritePost";
// eslint-disable-next-line new-cap
const favoriteRoute = express.Router();

favoriteRoute.post("/test", async (req, res) => {});

favoriteRoute.get("/", async (req, res) => {
	try {
		//TODOS get the user id from jwt
		// var cookie = getcookie(req);
		var user_id = {
			_id: new Types.ObjectId("62552d25dda547962d752216"),
		};

		// Fetch houses from favourite
		// Fetch favorite list from userid
		Favorite.find({ user_id: user_id }, "house_id").exec(
			async (err, docs) => {
				// take result(array) map into ids array of objectId
				var ids: Schema.Types.ObjectId[] = docs.map((e) => e.house_id);

				var house = await House.find({ _id: { $in: ids } }).exec();
				return res.json({ success: true, data: house });
			}
		);
	} catch (error) {
		return res.json({ success: false, error: error });
	}
});

favoriteRoute.post("/", async (req, res) => {
	try {
		//TODOS get the user id from jwt
		// var cookie = getcookie(req);
		var user_id = {
			_id: new Types.ObjectId("62552d25dda547962d752216"),
		};
		//parse body
		const body: FavouritePost = req.body;

		// check if the user favorited or not
		var favorite = await Favorite.findOne({
			house_id: body.house_id,
			user_id: user_id,
		});

		if (favorite) {
			var deleteFavorite = await favorite.remove();
			return res.json({ success: true, data: "remove from favorite!" });
		}
		var newFavorite = await new Favorite({
			house_id: body.house_id,
			user_id: user_id,
		}).save();

		return res.json({ success: true, data: "Added to favorite!" });
	} catch (error) {
		return res.json({ success: false, error: error });
	}
});

export default favoriteRoute;
