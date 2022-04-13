import express from "express";

const userRoute = express.Router();

userRoute.post("/signin", (req, res) => {
	return res.send();
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
