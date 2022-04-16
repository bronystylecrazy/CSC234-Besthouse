import express from "express";
import { NearbySearchGet, SearchPost } from "@/interface/api/Search";
import { SearchHouse, SearchNearbyHouse } from "@/services/Search";
import { responseHandler } from "@/services/Handler";
// eslint-disable-next-line new-cap
const houseRoute = express.Router();

houseRoute.post("/search", async (req, res) => {
	const data: SearchPost = req.body;
	return responseHandler(res, await SearchHouse(data));
});

// feature and nearby house are the same api
// you check by query string if no query string it mean get the position of user then search
// sorry for my mistake float
houseRoute.get("/near", async (req, res) => {
	const data: NearbySearchGet = req.body;
	return responseHandler(res, await SearchNearbyHouse(data));
});

export default houseRoute;
