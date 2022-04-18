export interface OfferPatch {
	name: "String";
	picture_url: "String";
	address: "String";
	location: {
		type: "Point";
		coordinates: [];
	};
	tags: ["String"];
	type: "String";
	rooms: [
		{
			type: "String";
			numbers: 0;
			pictures: [
				{
					url: "String";
				}
			];
		}
	];
	description: "String";
	price: "String";
	facilities: [
		{
			name: "String";
			checked: true;
		}
	];
	electric_fee: 0;
	likes: 0;
	total_size: 0;
	status: true;
}
