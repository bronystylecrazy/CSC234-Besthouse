export default interface House {
	name: string;
	picture_url: string;
	location: {
		type: string;
		coordinates: number[];
	};
	price: number;
	type: string;
	status: boolean;
	tags: string[];
}
