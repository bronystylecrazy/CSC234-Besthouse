import express from "express";
import { Login } from "@/services/Authentication";
import { Signin } from "@/interface/api/User";

const userRoute = express.Router();

userRoute.post("/signin", async (req, res) => {
	const { email, password }: Signin = req.body;
	const [result, error] = await Login(email, password);
	return response(res, result, error);
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
