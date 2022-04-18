import jwt from "jsonwebtoken";
import config from "@/config";

/**
 * Say "fuck you" to your game addictive friends.
 * @return {string}
 */
export function sayFuckyou() {
	console.log("Fuck you, Ann!");
	return "Fuck you, Ann!!";
}

/**
 * Generate jwt from given user_id and email.
 * @param {string} _id User's id.
 * @param {string} email User's email.
 * @return {string} Encoded jwt token.
 */
export function generateJwtToken(_id, email: string) {
	const payload = {
		user_id: _id,
		email,
	};
	const token = jwt.sign(payload, config.JWT_SECRET, {
		algorithm: "HS256",
		expiresIn: "7d",
	});

	return token;
}
