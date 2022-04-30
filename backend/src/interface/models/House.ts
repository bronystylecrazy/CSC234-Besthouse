export default interface House {
	name: string;
	picture_url: string;
	address: string;
	location: {
		type: "Point";
		coordinates: number[];
	};
	price: number;
	type: string;
	status: boolean;
	tags: string[];
	isAdvertised: boolean;
}
