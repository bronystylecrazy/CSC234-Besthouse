export interface SignIn {
	email: string;
	password: string;
}

export interface SignUp {
	username: string;
	password: string;
	email: string;
	firstname: string;
	lastname: string;
	tel: string;
}

export interface Forgot {}

export interface Reset {}
