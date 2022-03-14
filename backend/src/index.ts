require("module-alias/register");

/** Internal Modules */
import dotenv from "dotenv";
import express from "express";
import cors from "cors";

/** Routes */
import authRoute from "@/routes/auth";

/** Misc */
import AppConfig from "./config";

/** Instantiate Application */
const app = express();

/** Express configurations */
dotenv.config();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

/** Plugins */
app.use(cors());

/** Routes */
app.use("/auth", authRoute);

/** Start a server */
app.listen(AppConfig.PORT, "0.0.0.0", () => {
	console.log(`Server is running on port ${AppConfig.PORT}`);
});
