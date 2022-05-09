import express from "express";
import {  forgotPassword, login, signUp } from "@/services/Authentication";
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
	const {email}: ForgotPost = req.body;
	return responseHandler(res, await forgotPassword(email));
});


export default userRoute;
