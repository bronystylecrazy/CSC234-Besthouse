import express from "express";
import { login, signUp } from "@/services/Authentication";
import { SignInPost, SignUpPost } from "@/interface/api/User";
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

userRoute.post("/forgot", (req, res) => {
	return res.send();
});

userRoute.patch("/reset", (req, res) => {
	return res.send();
});

export default userRoute;
