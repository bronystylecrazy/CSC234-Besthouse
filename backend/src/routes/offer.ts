import { OfferPatch } from "@/interface/api/OfferType";
import { responseHandler } from "@/services/Handler";
import {
	CreateOffer,
	DeleteOffer,
	GetOffer,
	GetOfferById,
	GetOfferInfo,
	ToggleAvailable,
	UpdateOffer,
} from "@/services/House";
import express from "express";
import { Types } from "mongoose";

const offerRoute = express.Router();

offerRoute.get("/", async (req, res) => {
	return responseHandler(res, await GetOffer(req));
});

offerRoute.get("/user/:id", async (req, res) => {
	const { id } = req.params;
	return responseHandler(res, await GetOfferById(id));
});

offerRoute.get("/:id", async (req, res) => {
	const { id } = req.params;
	const house_id = new Types.ObjectId(id);
	return responseHandler(res, await GetOfferInfo(house_id, req));
});

offerRoute.post("/", async (req, res) => {
	const body: OfferPatch = req.body;
	return responseHandler(res, await CreateOffer(req, body));
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

offerRoute.patch("/toggle/:id", async (req, res) => {
	// get params
	const { id } = req.params;
	return responseHandler(res, await ToggleAvailable(id, req));
});

export default offerRoute;
