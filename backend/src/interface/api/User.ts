export interface SignInPost {
	username: string;
	password: string;
}

export interface SignUpPost {
	username: string;
	password: string;
	email: string;
	firstname: string;
	lastname: string;
	tel: string;
}

export interface ForgotPost {}

export interface ResetPatch {}
