import bcrypt from "bcrypt";
const saltRounds = 10;

import { Profile, User } from "@/database/models";

import { SignUpPost } from "@/interface/api/User";
import type { ResultHandler } from "@/interface/handler";
import { genericError, infoResponse } from "@/services/Handler";
import { generateJwtToken } from "@/utils";
import jwt from "express-jwt";


// const DOMAIN = 'sandbox447347814a94474988e3a1881ea197e1.mailgun.org';

// const formData = require('form-data');
// const Mailgun = require('mailgun-js');

// const mailgun = new Mailgun(formData);
// const client = mailgun.client({username: 'api', key: process.env.MAILGUN_APIKEY});


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

// export const forgotPassword = async (
// 	email: string,
// ): ResultHandler => {
// 	try {
	
// 	User.findOne({email}).exec();
// 	if (!User) return genericError("User is not found!", 400);

// 	const newPass = 'aidjed'
// 	const data = {
// 		from: 'noreply@besthouse.com',
// 		to: email,
// 		subject: 'Reset password',
// 		html:`
// 			<h2>Hi, this is Besthouse</h2>
// 			<p>Your new password is${newPass}</p>
// 		`
// 	}

// 	const sendemail = client.messages.create(DOMAIN, data)
// 	return infoResponse(sendemail, "Send email success", 201);
// } catch (e) {
// 	return genericError(e.message, 503);
// }
// };
	


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
