import type { Response } from "express";
import type { ResultHandler, ErrorResponse } from "@/interface/handler";
import type HttpStatus from "@/utils/httpStatus";

export const genericError = async (
	message = "",
	status: HttpStatus = 404
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
	status: HttpStatus = 200
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
	resultOrError: [unknown, ErrorResponse] | ErrorResponse
) => {
	if (Array.isArray(resultOrError)) {
		const [result, error] = resultOrError;
		if (error) return res.status(error.status).json(error);
		return res.json(result);
	}
	return res.json(resultOrError);
};
