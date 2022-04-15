import express from "express";
import { FavouritePost } from "@/interface/api/FavoritePost";
import { responseHandler } from "@/services/Handler";
import { FavoriteHouse, ListFavoriteHouse } from "@/services/House";
// eslint-disable-next-line new-cap
const favoriteRoute = express.Router();

favoriteRoute.get("/", async (req, res) => {
	return responseHandler(res, await ListFavoriteHouse(req));
});

favoriteRoute.post("/", async (req, res) => {
	const body: FavouritePost = req.body;
	return responseHandler(res, await FavoriteHouse(body, req));
});

export default favoriteRoute;
