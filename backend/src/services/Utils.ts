import { Request } from "express";

export const Islogin = (req: Request) => {
	if (!req.user) {
		return false;
	}
	return true;
};
