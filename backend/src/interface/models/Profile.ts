import { ObjectId } from "mongoose";
export default interface UserProfile {
	user_id: ObjectId;
	firstname: string;
	lastname: string;
	line_id: string;
	facebook: string;
	picture_url: string;
}
