import { ObjectId } from "mongoose";

export default interface HouseDetail {
	house_id: ObjectId;
	user_id: ObjectId;
	rooms: [
		{
			type: string;
			amount: number;
			pictures: [
				{
					url: string;
				}
			];
		}
	];
	description: string;
	facilities: [
		{
			name: string;
			checked: boolean;
		}
	];
	electric_fee: number;
	water_fee: number;
	likes: number;
	total_size: number;
}
