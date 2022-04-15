import { House, HouseDetail } from "@/database/models";

import { SearchPost } from "@/interface/api/Search";
import { ResultHandler } from "@/interface/handler";
import { infoResponse, genericError } from "./Handler";

export const SearchHouse = async (data: SearchPost): ResultHandler => {
	try {
		let condition = { status: true };
		if (data.pricelow) {
			//@ts-ignore
			condition.price = { $gte: data.pricelow };
		}
		if (data.pricehigh) {
			//@ts-ignore
			condition.price = { ...condition.price, $lte: data.pricehigh };
		}
		if (data.lat && data.long) {
			//@ts-ignore
			condition.location = {
				$near: {
					$geometry: {
						type: "Point",
						coordinates: [data.long, data.lat],
					},
					$maxDistance: 10000,
				},
			};
		}
		if (data.type) {
			//@ts-ignore
			condition.type = data.type;
		}
		if (data.facilities) {
			//@ts-ignore
			condition.facilities = { $in: data.facilities };
		}

		const houses = await House.find(condition).exec();

		if (houses.length === 0) return infoResponse([], "No house found");

		//@ts-ignore
		if (condition.facilities.lenght > 0) {
			var housesDetail = await HouseDetail.find({
				house_id: { $in: houses.map((house) => house._id) },
				facilities: { $all: data.facilities },
			});

			if (housesDetail.length === 0)
				return infoResponse([], "No house found");

			var finalHouses = houses.filter((house) => {
				return housesDetail.find((houseDetail) => {
					return (
						houseDetail.house_id.toString() === house._id.toString()
					);
				});
			});
		}

		return infoResponse(finalHouses || houses, "Search success");
	} catch (e) {
		return genericError(e.message, 503);
	}
};

export function SearchNearbyHouse() {}
