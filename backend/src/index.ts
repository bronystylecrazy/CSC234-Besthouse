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
import { User, House, Favorite } from "./database/models";
import favoriteRoute from "./routes/favorite";
import offerRoute from "./routes/offer";
import userRoute from "./routes/user";
import houseRoute from "./routes/house";

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
app.use("/favorite", favoriteRoute);
app.use("/offer", offerRoute);
app.use("/house", houseRoute);
app.use("/user", userRoute);

// for test
app.get("/api", async (req, res) => {
	var user1 = new User({
		email: "float@mail.com",
		password: "12345678",
		tel: "0891231234",
		username: "kasemtan",
	});
	var house1 = new House({
		name: "Condo1",
		picture_url:
			"https://transcode-v2.app.engoo.com/image/fetch/f_auto,c_limit,h_256,dpr_3/https://assets.app.engoo.com/images/ZFZlzPBXT8GEoefOiG62vz0oLFY7n2gkvbzGwcQsE0G.jpeg",
		location: {
			address: "---",
			latitude: "13.736717",
			longtitude: "100.523186",
		},
	});

	try {
		// const newUser = await user1.save();
		const newHouse = await house1.save();
		// var favorite1 = new Favorite({
		// 	house_id: newHouse._id,
		// 	user_id: newUser._id,
		// });
		// const newFavorite = await favorite1.save();
		return res.json({ newHouse });
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
