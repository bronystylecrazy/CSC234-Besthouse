import express from "express";
import { Favorite, House } from "@/database/models/index";
import { Types } from "mongoose";
import { getcookie } from "@/utils";
// eslint-disable-next-line new-cap
const favoriteRoute = express.Router();

favoriteRoute.get("/", async (req, res) => {
	//TODOS get the user id from jwt
	// var cookie = getcookie(req);

	var mockId = 1;
	// Fetch houses from favourite
	var houses_id = await Favorite.find({ user_id: mockId }, "house_id").exec(); // ObjectID[]

	var houses = await House.find({ _id: { $in: houses_id } });

	console.log(houses);

	return res.send("Fetch");
});

favoriteRoute.post("/", (req, res) => {
	return res.send("");
});

export default favoriteRoute;
