import { ObjectId } from "mongoose";

export default interface HouseDetail {
	house_id: ObjectId;
	user_id: ObjectId;
}
