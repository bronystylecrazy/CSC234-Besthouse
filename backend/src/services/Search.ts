import { House, HouseDetail } from "@/database/models";

import { NearbySearchGet, SearchPost } from "@/interface/api/Search";
import { ResultHandler } from "@/interface/handler";
import { infoResponse, genericError } from "./Handler";

export const searchHouse = async (data: SearchPost): ResultHandler => {
	try {
		let condition = {
			status: true,
			price: {
				$gte: data.price_low,
				$lte: data.price_high,
			},
		};

		if (data.type) {
			//@ts-ignore
			condition.type = data.type;
		}
		if (data.facilities) {
			//@ts-ignore
			condition.facilities = data.facilities;
		}

		if (data.lat && data.long) {
			//@ts-ignore
			condition.location = {
				$near: {
					$geometry: {
						type: "Point",
						coordinates: [data.long, data.lat],
					},
					$maxDistance: 5000,
				},
			};
		} else if (data.address) {
			//@ts-ignore
			condition.address = { $regex: data.address, $options: "i" };
		}

		// Get houses from provied condition
		const houses = await House.find(condition).exec();

		if (houses.length === 0) return infoResponse([], "No house found");

		// Check if user want to get facilities
		//@ts-ignore
		if (condition.facilities) {
			const housesDetails = await HouseDetail.find({
				house_id: { $in: houses.map((house) => house._id) },
				facilities: { $all: data.facilities },
			});

			if (housesDetails.length === 0)
				return infoResponse([], "No house with the facilities found");

			// Get only houseDetail that match the id from houses
			var finalHouses = houses.filter((house) => {
				return housesDetails.find((houseDetail) => {
					return (
						houseDetail.house_id.toString() === house._id.toString()
					);
				});
			});

			return infoResponse(
				finalHouses,
				"Search house with facilities success"
			);
		}

		return infoResponse(houses, "Search house success");
	} catch (e) {
		return genericError(e.message, 503);
	}
};

export const SearchNearbyHouse = async (data: NearbySearchGet) => {
	try {
		if (!data.lat || !data.long)
			return genericError("Latitude and longtitude is required", 400);

		const houses = await House.find({
			status: true,
			location: {
				$near: {
					$geometry: {
						type: "Point",
						coordinates: [data.long, data.lat],
					},
					$maxDistance: 5000,
				},
			},
		}).exec();

		if (houses.length === 0) return infoResponse([], "No house found");

		return infoResponse(houses, "Search success");
	} catch (e) {
		return genericError(e.message, 503);
	}
};

export const GetFeatureHouse = async (data: NearbySearchGet) => {
	try {
		if (!data.lat || !data.long)
			return genericError("Latitude and longtitude is required", 400);

		const houses = await House.find({
			status: true,
			is_advertised: true,
			location: {
				$near: {
					$geometry: {
						type: "Point",
						coordinates: [data.long, data.lat],
					},
					$maxDistance: 5000,
				},
			},
		}).exec();

		if (houses.length === 0) return infoResponse([], "No house found");

		return infoResponse(houses, "Search success");
	} catch (e) {
		return genericError(e.message, 503);
	}
};
