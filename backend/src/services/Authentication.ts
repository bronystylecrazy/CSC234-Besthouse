import jwt from "jsonwebtoken";
import { User } from "@/database/models";
import type { ResultHandler, ErrorResponse } from "@/interface/handler";
import { genericError, infoResponse } from "@/services/Handler";
import config from "@/config";

export const Login = async (email: string, password: string): ResultHandler => {
	try {
		// Login logic
		const myUser = await User.findOne({
			email,
		}).exec();

		if (!myUser) return genericError("Oh my god, user is not found!", 400);

		if (myUser.password !== password)
			return genericError(
				"Oh fuck, your email or password are not correct.",
				400
			);

		const token = jwt.sign(
			{
				user_id: myUser._id,
				email,
			},
			config.JWT_SECRET,
			{
				algorithm: "HS256",
				expiresIn: "7d",
			}
		);

		return infoResponse(token, "signin success");
	} catch (e) {
		return genericError(e.message, 503);
	}
};
