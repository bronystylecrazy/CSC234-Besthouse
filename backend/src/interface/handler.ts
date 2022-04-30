export type Response<T = {}> = {
	success: boolean;
	message: string;
	status: number;
	data: T;
};

export type ErrorResponse = Pick<Response, "success" | "message" | "status">;

export type ResultHandler<T = Response, K = ErrorResponse> = Promise<[T, K]>;
