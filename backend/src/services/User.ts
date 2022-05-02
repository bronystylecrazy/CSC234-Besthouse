import { Profile, User } from "@/database/models";
import { ProfilePatch, UserPatch } from "@/interface/api/ProfilePatch";
import { Request } from "express";
import { genericError, infoResponse } from "./Handler";
import { isLogin } from "./Utils";

export const GetUser = async (req: Request) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;

		const user = await User.findById(user_id, "email username tel");
		const profile = await Profile.findOne({ user_id: user_id });
		//if (!profile) return infoResponse([], "No profile found");

		return infoResponse({ user, profile });
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
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;

		// List houses detail by user id
		let profile = await Profile.findOneAndUpdate(
			{ user_id: user_id },
			bodyProfile,
			{ new: true }
		);

		const user = await User.findOneAndUpdate({ _id: user_id }, bodyUser, {
			new: true,
		});

		return infoResponse({ profile, user });
	} catch (error) {
		return genericError(error.message, 500);
	}
};
