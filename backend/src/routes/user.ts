import express from "express";
import {
	changePassword,
	forgotPassword,
	login,
	signUp,
} from "@/services/Authentication";
import { ForgotPost, SignInPost, SignUpPost } from "@/interface/api/User";
import { responseHandler } from "@/services/Handler";

const userRoute = express.Router();

userRoute.post("/signin", async (req, res) => {
	const { username, password }: SignInPost = req.body;
	return responseHandler(res, await login(username, password));
});

userRoute.post("/signup", async (req, res) => {
	const data: SignUpPost = req.body;
	return responseHandler(res, await signUp(data));
});

userRoute.patch("/forgot", async (req, res) => {
	const { email }: ForgotPost = req.body;
	return responseHandler(res, await forgotPassword(email));
});

userRoute.patch("/password", async (req, res) => {
	const { currentPass, newPass } = req.body;
	console.log(currentPass, newPass);

	return responseHandler(
		res,
		await changePassword(currentPass, newPass, req)
	);
});

export default userRoute;
