import chalk from "chalk";

export const log = (
	service = "Server",
	message = "",
	icon = "✨",
	emote = "😃"
) => {
	console.log(
		`${icon} ${chalk.yellowBright(service)} is ${chalk.green.bold(
			message
		)} ${emote}`
	);
};
