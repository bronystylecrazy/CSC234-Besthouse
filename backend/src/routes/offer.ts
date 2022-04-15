import { OfferPatch } from "@/interface/api/OfferType";
import { responseHandler } from "@/services/Handler";
import {
	DeleteOffer,
	GetOffer,
	GetOfferInfo,
	PostOffer,
	UpdateOffer,
} from "@/services/House";
import express from "express";
import { Types } from "mongoose";

const offerRoute = express.Router();

offerRoute.get("/", async (req, res) => {
	return responseHandler(res, await GetOffer(req));
});

offerRoute.get("/:id", async (req, res) => {
	const { id } = req.params;
	const house_id = new Types.ObjectId(id);
	return responseHandler(res, await GetOfferInfo(house_id));
});

offerRoute.post("/", async (req, res) => {
	const body: OfferPatch = req.body;
	return responseHandler(res, await PostOffer(req, body));
});

offerRoute.patch("/:id", async (req, res) => {
	// get params
	const { id } = req.params;
	const house_id = new Types.ObjectId(id);
	const body: OfferPatch = req.body;
	return responseHandler(res, await UpdateOffer(house_id, body, req));
});

offerRoute.delete("/:id", async (req, res) => {
	const { id } = req.params;
	const house_id = new Types.ObjectId(id);
	return responseHandler(res, await DeleteOffer(house_id, req));
});

export default offerRoute;
