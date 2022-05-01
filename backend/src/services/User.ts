import { Profile, User } from "@/database/models";
import { ProfilePatch, UserPatch } from "@/interface/api/ProfilePatch";
import { Request } from "express";
import { genericError, infoResponse } from "./Handler";
import { Islogin } from "./Utils";

export const GetUser = async (req: Request) => {
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
		//if (!profile) return infoResponse([], "No profile found");

		return infoResponse(profile);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const PatchUser = async (
	req: Request,
	bodyProfile: ProfilePatch,
	bodyUser: UserPatch
) => {
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
		let profile = await Profile.findOneAndUpdate(
			{ user_id: user_id },
			bodyProfile,
			{ new: true }
		);
		if (!profile)
			profile = await Profile.create({ ...bodyProfile, user_id });

		const user = await User.findOneAndUpdate({ _id: user_id }, bodyUser, {
			new: true,
		});

		return infoResponse({ profile, user });
	} catch (error) {
		return genericError(error.message, 500);
	}
};
