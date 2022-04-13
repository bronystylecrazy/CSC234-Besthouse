import express from "express";
import { Login } from "@/services/Authentication";
import { Signin } from "@/interface/api/User";
import { handler } from "@/services/Handler";

const userRoute = express.Router();

userRoute.post("/signin", async (req, res) => {
	const { email, password }: Signin = req.body;
	return handler(res, await Login(email, password));
});

userRoute.post("/signup", (req, res) => {
	return res.send();
});

userRoute.post("/forgot", (req, res) => {
	return res.send();
});

userRoute.patch("/reset", (req, res) => {
	return res.send();
});

export default userRoute;
