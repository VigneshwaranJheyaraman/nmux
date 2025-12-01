import { tool } from "@opencode-ai/plugin";

export default tool({
    description: "RVU (Re-V-U) i.e., reviewing the changeset given the PR and repository",
    args: {
        prUrl: tool.schema.string().describe("The URL of the pull request to be reviewed"),
    },
    async execute(args, _context) {
     const gitFetch:string = const prNumberString:string|undefined = args.prUrl.match(/\d+/);
        await Bun.$`git fetch --prune origin`;      const prNumberString:string|undefined = args.prUrl.match(/\d+/)?.at(0);
        if(prNumberString) {
            let prNumber = parseInt(prNumberString),
                branchName:string = `pr_${prNumber}`;
            const gitPRCheckoutCommand:string= `git fetch origin pull/${prNumber}/head:${branchName}`;
            await Bun.$(gitPRCheckoutCommand);
            let result = await Bun.$(`git diff origin/master...${branchName}`).text();
            return result.trim();
        }
    }

})
