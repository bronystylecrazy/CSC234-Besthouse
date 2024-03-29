import express from "express";
import { SearchPost, NearbySearchGet } from "@/interface/api/Search";
import {
	GetFeatureHouse,
	searchHouse,
	SearchNearbyHouse,
} from "@/services/Search";
import { genericError, responseHandler } from "@/services/Handler";
import { isLogin } from "@/services/Utils";
// eslint-disable-next-line new-cap
const searchRoute = express.Router();

searchRoute.post("/", async (req, res) => {
	if (!isLogin(req))
		return responseHandler(res, await genericError("Unauthorized", 401));

	const data: SearchPost = req.body;
	return responseHandler(res, await searchHouse(data));
});

// feature and nearby house are the same api
// you check by query string if no query string it mean get the position of user then search
searchRoute.get("/near", async (req, res) => {
	const data: NearbySearchGet = req.query;

	return responseHandler(res, await SearchNearbyHouse(data));
});

searchRoute.get("/feature", async (req, res) => {
	const data: NearbySearchGet = req.query;

	return responseHandler(res, await GetFeatureHouse(data));
});

export default searchRoute;
