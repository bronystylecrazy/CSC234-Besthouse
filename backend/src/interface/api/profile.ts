import { userProfileSchema } from "@/database/models/schema";
import express from "express";

// eslint-disable-next-line new-cap
const profileRoute = express.Router();

profileRoute.get("/profile/:username", async (req, res) => {
	const username = req.params.username;
	const result = await userProfileSchema
		.query()
		.findOne({ username: username });
	return res.send({
		success: true,
		data: result,
	});
});

profileRoute.patch("/profile/:username", async (req, res) => {
	// const username = req.params.username;
	const email = req.body.email;
	const firstName = req.body.firstName;
	const lastName = req.body.lastName;
	const tel = req.body.tel;
	const facebook = req.body.facebook;
	const lineId = req.body.line_id;
	// await userProfileSchema.query().patchAndFetchById(username, {
	//     email: email,
	//     firstName: firstName,
	//     lastName: lastName,
	//     tel: tel,
	//     facebook: facebook,
	//     line_id: lineId,
	// })

	const username = req.params.username;
	const user = await userProfileSchema
		.query()
		.findOne({ username: username });
	user.email = email;
	user.firstName = firstName;
	user.lastName = lastName;
	user.tel = tel;
	user.facebook = facebook;
	user.line_id = lineId;

	return await res.send({
		success: true,
		data: "profile updated!",
	});
});
