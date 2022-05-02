import bcrypt from "bcrypt";
const saltRounds = 10;

import { Profile, User } from "@/database/models";

import { SignUpPost } from "@/interface/api/User";
import type { ResultHandler } from "@/interface/handler";
import { genericError, infoResponse } from "@/services/Handler";
import { generateJwtToken } from "@/utils";

export const login = async (
	username: string,
	password: string
): ResultHandler => {
	try {
		// Fetches user from database
		const myUser = await User.findOne({
			username,
		}).exec();

		if (!myUser) return genericError("User is not found!", 400);

		// Check password
		const match = await bcrypt.compare(password, myUser.password);
		if (!match)
			return genericError("Sorry, your password is not correct.", 400);

		// Return token
		const token = generateJwtToken(myUser._id, myUser.username);

		return infoResponse(token, "Sign in success");
	} catch (e) {
		return genericError(e.message, 503);
	}
};

export const signUp = async (data: SignUpPost): ResultHandler => {
	try {
		// Hash password
		const { password, ...props } = data;
		if (password.length < 4) {
			return genericError("Password lenght must not less than 4", 400);
		}

		// Create user
		const hashedPassword = await bcrypt.hash(password, saltRounds);
		const myUser = new User({ ...props, password: hashedPassword });
		const myUserProfile = new Profile({ ...props, user_id: myUser._id });
		try {
			await myUser.save();
			await myUserProfile.save();
		} catch (e) {
			return genericError(e.message, 400);
		}

		// Return token
		const token = generateJwtToken(myUser._id, myUser.email);

		return infoResponse(token, "Sign up success", 201);
	} catch (e) {
		return genericError(e.message, 503);
	}
};
