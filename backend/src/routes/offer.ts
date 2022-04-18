import { OfferPatch } from "@/interface/api/OfferType";
import { responseHandler } from "@/services/Handler";
import { deleteOffer, getOfferInfo, updateOffer } from "@/services/House";
import express from "express";
import { Types } from "mongoose";

// eslint-disable-next-line new-cap
const offerRoute = express.Router();

offerRoute.get("/", (req, res) => {
	return res.send("Not implemented");
});

offerRoute.get("/:id", async (req, res) => {
	const { id } = req.params;
	const house_id = new Types.ObjectId(id);
	return responseHandler(res, await getOfferInfo(house_id));
});

offerRoute.post("/", (req, res) => {
	return res.send("Not implemented");
});

offerRoute.patch("/:id", async (req, res) => {
	// get params
	const { id } = req.params;
	const house_id = new Types.ObjectId(id);
	const body: OfferPatch = req.body;
	return responseHandler(res, await updateOffer(house_id, body, req));
});

offerRoute.delete("/:id", async (req, res) => {
	const { id } = req.params;
	const house_id = new Types.ObjectId(id);
	return responseHandler(res, await deleteOffer(house_id, req));
});

export default offerRoute;
