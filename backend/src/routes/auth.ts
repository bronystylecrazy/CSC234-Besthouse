import express from "express";
import { nanoid } from "nanoid";
// eslint-disable-next-line new-cap
const authRoute = express.Router();

authRoute.get("/", (req, res) => {
	return res.send(`Auth route ${nanoid(64)}`);
});

export default authRoute;
