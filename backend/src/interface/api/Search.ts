import { HouseType } from "@/database/models/schema";

export interface SearchPost {
	pricelow?: number;
	pricehigh?: number;
	type?: HouseType;
	facilities?: string[];
	lat?: number;
	long?: number;
}

export interface NearbySearchGet {
	lat?: number;
	long?: number;
}
