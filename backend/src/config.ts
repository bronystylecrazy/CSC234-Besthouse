const AppConfig = {
	PORT: +process.env.SERVER_PORT || 8080,
	MONGODB_HOST: process.env.MONGODB_HOST,
	JWT_SECRET: process.env.JWT_SECRET || "HelloWorld",
};

export default AppConfig;
