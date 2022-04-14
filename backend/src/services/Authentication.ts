import jwt from "jsonwebtoken";
import config from "@/config";

import bcrypt from "bcrypt";
const saltRounds = 10;

import { User } from "@/database/models";

import type { ResultHandler } from "@/interface/handler";
import { genericError, infoResponse } from "@/services/Handler";
import { SignUp as SignUpType } from "@/interface/api/User";

export const Login = async (email: string, password: string): ResultHandler => {
	try {
		// Login logic
		const myUser = await User.findOne({
			email,
		}).exec();

		if (!myUser) return genericError("Oh my god, user is not found!", 400);

		const match = await bcrypt.compare(password, myUser.password);
		if (!match)
			return genericError(
				"Sorry, your email or password is not correct.",
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

		return infoResponse(token, "Sign in success");
	} catch (e) {
		return genericError(e.message, 503);
	}
};

export const SignUp = async (data: SignUpType): ResultHandler => {
	try {
		// Check if fields are empty
		const requiredProps = [
			"email",
			"password",
			"username",
			"firstname",
			"lastname",
			"tel",
		];
		const isFullfill = requiredProps.every((prop) => prop in data);
		if (!isFullfill)
			return genericError(
				"Sorry, your information is not complete.",
				400
			);

		// Hash password
		const { password, ...props } = data;
		const hashedPassword = await bcrypt.hash(password, saltRounds);

		// Create user
		const myUser = new User({ ...props, password: hashedPassword });
		await myUser.save((err) => {
			if (err)
				return genericError(
					"Sorry, your information is not correct",
					400
				);
		});

		// Return token
		const token = jwt.sign(
			{
				user_id: myUser._id,
				email: myUser.email,
			},
			config.JWT_SECRET,
			{
				algorithm: "HS256",
				expiresIn: "7d",
			}
		);

		return infoResponse(token, "Sign up success");
	} catch (e) {
		return genericError(e.message, 503);
	}
};
