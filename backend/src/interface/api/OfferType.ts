export interface OfferPatch {
	name: string;
	picture_url: string;
	address: string;
	location: {
		type: "Point";
		coordinates: [];
	};
	tags: [string];
	type: string;
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
	price: string;
	facilities: [
		{
			name: string;
			checked: true;
		}
	];
	electric_fee: number;
	water_fee: number;
	likes: number;
	total_size: number;
	status: true;
}
