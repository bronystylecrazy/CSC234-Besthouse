import { ObjectId } from "mongoose";

export default interface HouseDetail {
	house_id: ObjectId;
	user_id: ObjectId;
	type: string;
	rooms: [
		{
			type: string;
			numbers: number;
			pictures: [
				{
					url: string;
				}
			];
		}
	];
	description: string;
	price: string;
	facilities: [
		{
			name: string;
			checked: boolean;
		}
	];
	electric_fee: number;
	likes: number;
	total_size: number;
}
