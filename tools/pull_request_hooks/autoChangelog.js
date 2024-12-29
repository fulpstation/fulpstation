import { parseChangelog } from "./changelogParser.js";

const safeYml = (string) =>
	string.replace(/\\/g, "\\\\").replace(/"/g, '\\"').replace(/\n/g, "\\n");

export function changelogToYml(changelog, login) {
	const author = changelog.author || login;
	const ymlLines = [];

	ymlLines.push(`author: "${safeYml(author)}"`);
	ymlLines.push(`delete-after: True`);
	ymlLines.push(`changes:`);

	for (const change of changelog.changes) {
		ymlLines.push(
			`  - ${change.type.changelogKey}: "${safeYml(change.description)}"`
		);
	}

	return ymlLines.join("\n");
}

export async function processAutoChangelog({ github, context }) {
	const changelog = parseChangelog(context.payload.pull_request.body);
	if (!changelog || changelog.changes.length === 0) {
		console.log("no changelog found");
		return;
	}

	const yml = changelogToYml(
		changelog,
		context.payload.pull_request.user.login
	);

	github.rest.repos.createOrUpdateFileContents({
		owner: context.repo.owner,
		repo: context.repo.repo,
		// Fulp Edit: Changes the path to our changelog folder (html/changelogs/... -> fulp_modules/data/html/changelogs...)
		path: `fulp_modules/data/html/changelogs/AutoChangeLog-pr-${context.payload.pull_request.number}.yml`,
		// Fulp Edit End
		message: `Automatic changelog for PR #${context.payload.pull_request.number} [ci skip]`,
		content: Buffer.from(yml).toString("base64"),
	});
}
