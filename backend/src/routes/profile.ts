/* eslint-disable new-cap */
import express from "express";
import { GetUserProfile, PatchUserProfile } from "@/services/UserProfile";
import { responseHandler } from "@/services/Handler";
import { ProfilePatch } from "@/interface/api/ProfilePatch";

// eslint-disable-next-line new-cap
const profileRoute = express.Router();

profileRoute.get("/:id", async (req, res) => {
	return responseHandler(res, await GetUserProfile(req));
});

profileRoute.patch("/:id", async (req, res) => {
	const body: ProfilePatch = req.body;
	return responseHandler(res, await PatchUserProfile(req, body));
});

export default profileRoute;
