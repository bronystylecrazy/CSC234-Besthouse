import express from "express";
import type { FavouritePost } from "@/interface/api/FavoritePost";
import { responseHandler } from "@/services/Handler";
import { favoriteHouse, listFavoriteHouse } from "@/services/House";
// eslint-disable-next-line new-cap
const favoriteRoute = express.Router();

favoriteRoute.get("/", async (req, res) => {
	return responseHandler(res, await listFavoriteHouse(req));
});

favoriteRoute.post("/", async (req, res) => {
	const body: FavouritePost = req.body;
	return responseHandler(res, await favoriteHouse(body, req));
});

export default favoriteRoute;
