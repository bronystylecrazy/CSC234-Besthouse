import { sayFuckyou } from "@/utils";

describe("Just to say fuck you", () => {
	it("should say fuck you to Ann", () => {
		expect(sayFuckyou()).toBe("Fuck you, Ann!!");
	});
});
