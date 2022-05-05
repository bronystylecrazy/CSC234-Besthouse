/* eslint-disable require-jsdoc */
/* eslint-disable @typescript-eslint/no-var-requires */
const esbuild = require("esbuild");

const { nodeExternalsPlugin } = require("esbuild-node-externals");
const chalk = require("chalk");
const { spawn } = require("child_process");

let node = null;
let t = performance.now();
const time = () => (performance.now() - t).toFixed(2);
function stopNodejsProcess() {
	if (node) {
		node.stdin.pause();
		node.kill();
		t = performance.now();
		console.log("stop!");
	}
}

function startNodejsProcess(app = "dist/index.js") {
	node = spawn("node", [app]);
	node.stdout.on("data", (data) => process.stdout.write(data));
}

esbuild
	.build({
		entryPoints: ["./src/index.ts"],
		outfile: "dist/index.js",
		bundle: true,
		minify: true,
		platform: "node",
		sourcemap: false,
		target: "node16",
		plugins: [nodeExternalsPlugin()],
		incremental: true,
		watch: {
			onRebuild: (err, res) => {
				stopNodejsProcess();
				if (err) {
					console.log(chalk.red(err));
					return;
				}
				console.log(
					`⚡ ${chalk.blueBright(
						`Build completed`
					)} ${chalk.greenBright(`(${time()}ms)`)} ⚡`
				);
				startNodejsProcess();
			},
		},
	})
	.then(() => {
		console.log(
			`⚡ ${chalk.blueBright(`Build completed`)} ${chalk.greenBright(
				`(${time()}ms)`
			)} ⚡`
		);
		console.log(`🔥 ${chalk.cyanBright(`Watching for changes...`)} 🔥`);
		startNodejsProcess();
	})
	.catch(() => process.exit(1));
