import { ResultHandler } from "@/interface/handler";
import { infoResponse } from "./Handler";

export const upload = (files = []): ResultHandler => {
	return infoResponse(null, "Success!");
};
