import express from "express";
// eslint-disable-next-line new-cap
const houseRoute = express.Router();

houseRoute.get("/search/:id", (req, res) => {
	return res.send();
});

houseRoute.get("/search", (req, res) => {
	return res.send();
});

// feature and nearby house are the same api
// you check by query string if no query string it mean get the position of user then search
// sorry for my mistake float
houseRoute.get("/near", (req, res) => {
	return res.send();
});

export default houseRoute;
