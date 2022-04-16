/* eslint-disable camelcase */
/* eslint-disable @typescript-eslint/ban-ts-comment */
/* eslint-disable new-cap */
import { Profile } from "@/database/models";
import { ProfilePatch } from "@/interface/api/ProfilePatch";
import { Request } from "express";
import { genericError, infoResponse } from "./Handler";
import { Islogin } from "./Utils";

export const GetUserProfile = async (req: Request) => {
	try {
		if (!Islogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		// @ts-ignore
		const user_id = req.user.user_id;

		// List houses detail by user id
		const profile = await Profile.findOne({ user_id: user_id });

		return infoResponse(profile);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const PatchUserProfile = async (req: Request, body: ProfilePatch) => {
	try {
		if (!Islogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		// @ts-ignore
		const user_id = req.user.user_id;

		// List houses detail by user id
		const profile = await Profile.findOneAndUpdate(
			{ user_id: user_id },
			body,
			{ new: true }
		);

		return infoResponse(profile);
	} catch (error) {
		return genericError(error.message, 500);
	}
};
