import bcrypt from "bcrypt";
const saltRounds = 10;

import { Profile, User } from "@/database/models";

import { SignUpPost } from "@/interface/api/User";
import type { ResultHandler } from "@/interface/handler";
import { genericError, infoResponse } from "@/services/Handler";
import { generateJwtToken } from "@/utils";
import { isLogin } from "./Utils";
import { Request } from "express";

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

const nodemailer = require("nodemailer");
var generator = require("generate-password");

export const changePassword = async (
	currentPass: string,
	newPassword: string,
	req: Request
) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;
		// Hash password
		if (newPassword.length < 4) {
			return genericError("Password lenght must not less than 4", 400);
		}

		const myUser = await User.findOne({
			_id: user_id,
		});
		const match = await bcrypt.compare(currentPass, myUser.password);
		if (!match)
			return genericError("Sorry, your password is not correct.", 400);

		// Create user
		const hashedPassword = await bcrypt.hash(newPassword, saltRounds);
		try {
			await myUser.update({ $set: { password: hashedPassword } });
		} catch (e) {
			return genericError(e.message, 400);
		}

		return infoResponse(null, "Change password success", 201);
	} catch (e) {
		return genericError(e.message, 503);
	}
};

export const forgotPassword = async (email: string): ResultHandler => {
	try {
		const myUser = await User.findOne({
			email,
		}).exec();
		if (!myUser) return genericError("User is not found!", 400);
		else {
			const newPass = generator.generate({
				length: 10,
				numbers: true,
				lowercase: true,
				uppercase: true,
			});

			console.log("new pass for " + email + " : " + newPass);

			let transport = nodemailer.createTransport({
				service: "gmail",
				type: "SMTP",
				host: "smtp.gmail.com",
				secure: true,
				auth: {
					user: "weareyour.besthouse@gmail.com",
					pass: "Besthouse2022",
				},
			});
			const message = {
				from: "weareyour.besthouse@gmail.com", // Sender address
				to: email,
				subject: "New password for Besthouse", // Subject line
				text: "This is your new password : " + newPass, // Plain text body
			};
			transport.sendMail(message, function (err, info) {
				if (err) {
					console.log(err);
				} else {
					console.log(info);
				}
			});

			const hashedPassword = await bcrypt.hash(newPass, saltRounds);
			const updateUser = await User.findOneAndUpdate(
				{ email: email },
				{ password: hashedPassword },
				{
					new: true,
				}
			);
		}

		return infoResponse(
			"",
			"Send email success! \nPlease check your mail inbox.",
			201
		);
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
