const AppConfig = {
	PORT: +process.env.SERVER_PORT || 8080,
	MONGODB_HOST: process.env.MONGODB_HOST,
};

export default AppConfig;
