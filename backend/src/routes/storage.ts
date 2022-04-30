/* eslint-disable new-cap */
import express from "express";
import multer from "multer";
import util from "util";
import path from "path";
import fs from "fs";
import { nanoid } from "nanoid";
import { genericError, responseHandler } from "@/services/Handler";

// import sharp from "sharp";
// const resizeImages = async (req, res, next) => {
//   if (!req.files) return next();
//   req.body.images = [];
//   if (!fs.existsSync(path.join(`${__dirname}/../../../storage/min`))){
// 		fs.mkdirSync(path.join(`${__dirname}/../../../storage/min`));
//   }

//   await Promise.all(
//     req.files.map(async file => {
//       await sharp(file.buffer)
// 			.resize(640, 320)
// 			.toFormat("jpeg")
// 			.jpeg({ quality: 90 })
// 			.toFile(`upload/${file.filename}`);
//       req.body.images.push(newFilename);
//     })
//   );
//   next();
// };

console.log(
	`Storage service will be on ${path.join(`${__dirname}/../../../storage`)}`
);
if (fs.existsSync(path.join(`${__dirname}/../../../storage`))) {
	console.log("Storage service is already exist");
} else {
	fs.mkdirSync(path.join(`${__dirname}/../../../storage`));
}

var storage = multer.diskStorage({
	destination: (req, file, callback) => {
		callback(null, path.join(`${__dirname}/../../../storage`));
	},
	filename: async (req, file, callback) => {
		const match = ["image/png", "image/jpeg"];
		if (match.indexOf(file.mimetype) === -1) {
			var message = `${file.originalname} is invalid. Only accept png/jpeg.`;
			const [, err] = await genericError(message, 400);
			return callback(err.message, null);
		}
		var filename = `${Date.now()}-${nanoid()}${path.extname(
			file.originalname
		)}`;
		callback(null, filename);
	},
	onError: function (err, next) {
		next(err);
	},
});

var uploadFiles = multer({ storage: storage }).array("files", 10);
var uploadFilesMiddleware = util.promisify<any>(uploadFiles);

const storageRoute = express.Router();

storageRoute.use(uploadFilesMiddleware);

storageRoute.post("/", (req, res, err) => {
	console.log(err);
	return res.json(
		(req as any).files.map((file) => ({
			url: "/storage/" + file.filename,
			name: file.originalname,
			size: file.size,
			type: file.mimetype,
			createdAt: new Date().toISOString(),
		}))
	);
});

storageRoute.get("/:filename", async (req, res) => {
	try {
		const { filename } = req.params;
		if (
			!filename ||
			!fs.existsSync(
				path.join(`${__dirname}/../../../storage/${filename}`)
			)
		) {
			return responseHandler(
				res,
				await genericError("File not found!", 404)
			);
		}
		// return picture by file stream
		const file = fs.createReadStream(
			path.join(`${__dirname}/../../../storage`, filename)
		);
		res.setHeader("Content-Type", "image/jpg");
		return file.pipe(res);
	} catch (e) {
		return res.status(400).json(e);
	}
});

export default storageRoute;
