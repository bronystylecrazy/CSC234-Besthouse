declare global {
	namespace Express {
		// tslint:disable-next-line:no-empty-interface
		interface User {
			user_id: string;
			email: string;
			iat: number;
			exp: number;
		}

		interface Request {
			user?: User | undefined;
		}
	}
}
