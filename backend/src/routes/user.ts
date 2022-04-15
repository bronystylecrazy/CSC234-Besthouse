import express from "express";
import { Login, SignUp } from "@/services/Authentication";
import {
	SignIn as SignInType,
	SignUp as SignUpType,
} from "@/interface/api/User";
import { responseHandler } from "@/services/Handler";

const userRoute = express.Router();

userRoute.post("/signin", async (req, res) => {
	const { email, password }: SignInType = req.body;
	return responseHandler(res, await Login(email, password));
});

userRoute.post("/signup", async (req, res) => {
	const data: SignUpType = req.body;
	return responseHandler(res, await SignUp(data));
});

userRoute.post("/forgot", (req, res) => {
	return res.send();
});

userRoute.patch("/reset", (req, res) => {
	return res.send();
});

export default userRoute;
