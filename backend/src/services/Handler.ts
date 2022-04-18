import type { Response } from "express";
import type { ResultHandler, ErrorResponse } from "@/interface/handler";

export const genericError = async (
	message = "",
	status = 404
): ResultHandler => {
	return [
		null,
		{
			success: false,
			message,
			status,
		} as ErrorResponse,
	];
};

export const infoResponse = async (
	data: unknown,
	message = "Success!",
	status = 200
): ResultHandler => {
	return [
		{
			data,
			success: true,
			message,
			status,
		},
		null,
	];
};

export const responseHandler = (
	res: Response,
	resultOrError: [unknown, ErrorResponse]
) => {
	const [result, error] = resultOrError;
	if (error) return res.status(error.status).json(error);
	return res.json(result);
};
