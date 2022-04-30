import { ObjectId } from "mongoose";

export default interface Favorite {
	house_id: ObjectId;
	user_id: ObjectId;
}
