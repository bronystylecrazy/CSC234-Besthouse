import express from "express";
import { Login, SignUp } from "@/services/Authentication";
import { SignInPost, SignUpPost } from "@/interface/api/User";
import { responseHandler } from "@/services/Handler";

const userRoute = express.Router();

userRoute.post("/signin", async (req, res) => {
	const { email, password }: SignInPost = req.body;
	return responseHandler(res, await Login(email, password));
});

userRoute.post("/signup", async (req, res) => {
	const data: SignUpPost = req.body;
	return responseHandler(res, await SignUp(data));
});

userRoute.post("/forgot", (req, res) => {
	return res.send();
});

userRoute.patch("/reset", (req, res) => {
	return res.send();
});

export default userRoute;
