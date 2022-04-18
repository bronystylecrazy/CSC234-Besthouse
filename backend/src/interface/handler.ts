import type HttpStatus from "@/utils/httpStatus";

export type Response<T = unknown> = {
	success: boolean;
	message: string;
	status: HttpStatus;
	data: T;
};

export type ErrorResponse = Pick<Response, "success" | "message" | "status">;

export type ResultHandler<T = Response, K = ErrorResponse> = Promise<[T, K]>;
