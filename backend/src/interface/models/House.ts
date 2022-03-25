export default interface House {
	name: string;
	picture_url: string;
	location: {
		address: string;
		latitude: string;
		longtitude: string;
	};
	status: boolean;
	tags: string[];
}
