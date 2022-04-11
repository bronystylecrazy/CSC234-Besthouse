require("dotenv").config();
require("module-alias/register");

/** Internal Modules */
import dotenv from "dotenv";
import express from "express";
import cors from "cors";

/** Routes */
import authRoute from "@/routes/auth";
import profileRoute from "./routes/profile";

/** Misc */
import AppConfig from "./config";
// import { House, User } from "./database/models/schema";
import { func } from "joi";
import mongoose from "mongoose";
import { User } from "./database/models";

/** Instantiate Application */
const app = express();

/** Express configurations */
dotenv.config();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

/** Plugins */
app.use(cors());

/** Routes */
app.use("/auth", authRoute);
app.use("/profile", profileRoute);

app.get("/api", async (req, res) => {
	var user1 = new User({
		email: "baba",
		password: "asdsadhashed",
		tel: "1231231",
		username: "asdasd",
	});
	// var house1 = new House({
	// 	name: "asdsad",
	// 	picture_url: "sadsad",
	// 	location: {
	// 		address: "asdsad",
	// 		latitude: "asda",
	// 		longitude: "asdsdcoc",
	// 	},
	// });
	try {
		const newUser = await user1.save();
		return res.json(newUser);
	} catch (e) {
		return res.status(400).json(e);
	}
});

/** Start a server */

mongoose
	.connect(AppConfig.MONGODB_HOST)
	.then(() =>
		app.listen(AppConfig.PORT, "0.0.0.0", () => {
			console.log(`Server is running on port ${AppConfig.PORT}`);
		})
	)
	.catch((err) => console.error("What the fuck is going on??", err));
