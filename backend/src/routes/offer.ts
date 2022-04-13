import { House, HouseDetail } from "@/database/models";
import { OfferPatch } from "@/interface/api/OfferType";
import express from "express";
import { Types, Schema } from "mongoose";

const offerRoute = express.Router();

offerRoute.get("/", (req, res) => {});

offerRoute.get("/:id", (req, res) => {});

offerRoute.post("/", (req, res) => {});

offerRoute.patch("/:id", async (req, res) => {
	try {
		//TODOS get the user id from jwt
		// var cookie = getcookie(req);
		var user_id = new Types.ObjectId("62552d25dda547962d752216");

		// get params
		var { id } = req.params;

		// convert id to objectid
		var house_id: Types.ObjectId = new Types.ObjectId(id);

		// check permission
		const houseDetail1 = await HouseDetail.findOne({
			user_id: user_id,
			house_id: house_id,
		}).exec();

		if (houseDetail1 == null) {
			return res
				.status(400)
				.json({ success: false, err: "Unauthorized user" });
		}

		// parse body
		var body: OfferPatch = req.body;

		// update house and houseDetail
		await House.updateOne(
			{ _id: house_id },
			{
				$set: {
					name: body.name,
					location: body.location,
					picture_url: body.picture_url,
					tags: body.tags,
				},
			}
		).exec();
		await houseDetail1
			.updateOne({
				$set: {
					description: body.description,
					electric_fee: body.electric_fee,
					facilities: body.facilities,
					house_id: house_id,
					price: body.price,
					rooms: body.rooms,
					total_size: body.total_size,
					type: body.type,
				},
			})
			.exec();

		return await res
			.status(200)
			.json({ success: true, data: "offer edited!" });
	} catch (error) {
		return res.status(400).json({ success: false, err: error.message });
	}
});

offerRoute.delete("/:id", (req, res) => {});

export default offerRoute;
