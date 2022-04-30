import express from "express";
import { SearchPost } from "@/interface/api/Search";
import { searchHouse } from "@/services/Search";
import { genericError, responseHandler } from "@/services/Handler";
import { isLogin } from "@/services/Utils";
// eslint-disable-next-line new-cap
const houseRoute = express.Router();

houseRoute.post("/search", async (req, res) => {
	if (!isLogin(req))
		return responseHandler(res, await genericError("Unauthorized", 403));

	const data: SearchPost = req.body;
	return responseHandler(res, await searchHouse(data));
});

houseRoute.post("/", async (req, res) => {
	if (!isLogin(req))
		return responseHandler(res, await genericError("Unauthorized", 403));
});

// feature and nearby house are the same api
// you check by query string if no query string it mean get the position of user then search
// sorry for my mistake float
houseRoute.get("/near", (req, res) => {
	return res.send();
});

export default houseRoute;
