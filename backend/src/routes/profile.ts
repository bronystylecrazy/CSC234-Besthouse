import express from "express";
import { Profile } from "@/database/models/index";
// eslint-disable-next-line new-cap
const profileRoute = express.Router();

profileRoute.get("/:username", async (req, res) => {
	const username = req.params.username;
	const userProfile = await Profile.findOne({ username: username });
	if (userProfile) {
		res.send({
			success: true,
			data: userProfile,
		});
	} else {
		res.send({
			success: false,
			message: "User not found",
		});
	}
});

profileRoute.patch("/:username", async (req, res) => {
	const username = req.params.username;
	const { firstname, lastname, lineId, facebook } = req.body;
	const userProfile = new Profile({
		username,
		firstname,
		lastname,
		lineId,
		facebook,
	});
	await userProfile.save();
	if (userProfile) {
		res.send({
			success: true,
			data: userProfile,
		});
	} else {
		res.send({
			success: false,
			message: "User not update information",
		});
	}
});

export default profileRoute;
