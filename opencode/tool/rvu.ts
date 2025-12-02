import { tool } from "@opencode-ai/plugin";

export default tool({
    description: "RVU (Re-V-U) i.e., reviewing the changeset given the PR and repository information as URL and local work directory",
    args: {
        prUrl: tool.schema.string().describe("The URL of the pull request to be reviewed"),
        workingDir : tool.schema.string().describe("The local working directory of the repository"),
    },
    async execute(args, _context) {
        args.workingDir && await Bun.$.cwd(args.workingDir);
        await Bun.$`git fetch --prune origin`.nothrow().quiet();
        const prNumberString:string|undefined = args.prUrl.match(/\d+/)?.at(0);
        if(prNumberString) {
            let prNumber = parseInt(prNumberString),
                branchName:string = `pr_${prNumber}`;
            await Bun.$`git fetch origin pull/${prNumber}/head:${branchName}`.nothrow().quiet();
            let result = await Bun.$`git diff origin/master...${branchName}`.text();
            Bun.$`git branch -D ${branchName}`.nothrow().quiet();
            return result.trim();
        }
    }

})
