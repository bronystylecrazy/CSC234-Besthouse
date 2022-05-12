import { HouseType } from "@/database/models/schema";

export interface SearchPost {
	price_low?: number;
	price_high?: number;
	type?: HouseType;
	facilities?: string[];
	address?: string;
	lat?: number;
	long?: number;
}

export interface NearbySearchGet {
	lat?: number;
	long?: number;
}
