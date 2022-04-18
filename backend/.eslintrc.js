module.exports = {
	env: {
		browser: false,
		es2021: true,
		jest: true,
		node: true,
	},
	extends: ["plugin:@typescript-eslint/recommended", "google", "prettier"],
	parser: "@typescript-eslint/parser",
	parserOptions: {
		ecmaVersion: "latest",
		sourceType: "module",
	},
	plugins: ["@typescript-eslint"],
	rules: {
		"no-unused-vars": "off",
		camelcase: "off",
		"@typescript-eslint/no-unused-vars": "off",
		"@typescript-eslint/no-unused-vars-experimental": "off",
		// turn off capitalization for all variables
	},
};
