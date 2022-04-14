import express from "express";
import { nanoid } from "nanoid";
// eslint-disable-next-line new-cap
const authRoute = express.Router();

authRoute.get("/", (req, res) => {
	console.log(req.user);
	// return res.send(`Auth route ${nanoid(64)}`);
	return res.json(req.user);
});

export default authRoute;
