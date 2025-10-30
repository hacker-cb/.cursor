# Auto-Fix Project Based on GitHub Workflow Failures

## Overview
This command analyzes GitHub workflow runs, watches for failed runs, and automatically applies fixes until all workflows pass. If any workflow is currently running, it waits for the result before proceeding, then handles failures iteratively.

## Common

- Use `gh` CLI command for working with GitHub workflows

### Key Commands
- List all workflows: `gh workflow list`
- Check last run for specific workflow: `gh run list --workflow=<workflow-name> --limit 1`
- View workflow run details: `gh run view <run-id>`
- View failed jobs: `gh run view <run-id> --log-failed`
- Re-run failed jobs: `gh run rerun <run-id> --failed`
- Check workflow status (wait for completion): `gh run watch <run-id>`

## Steps
1. **Check and prepare**
   - Get current branch: `git branch --show-current`
   - List all defined workflows: `gh workflow list`
   - For each workflow, check last run status: `gh run list --workflow=<workflow-name> --limit 1`
   - Identify workflows with runs in progress, failed, passed, or never run
   - If any workflow is still running, use `gh run watch <run-id>` to wait for completion before analyzing results
   - For each failed run: `gh run view <run-id> --log-failed` to view error details
   - Provide a summary: total workflows, which passed, which failed, which are running, which never ran
   - If more than one workflow fails, ask user which workflow to prioritize (Single workflow, All workflows)

2. **Request user for permission**
   - Provide status on current git branch and changes
   - State agent requires commit and push permissions for applied changes
   - Request explicit user permission for commit and push

3. **Fixing Loop**
   - For each failed workflow:
     - Analyze error logs from failed jobs
     - Apply fixes to project files
     - Commit changes with a descriptive message
     - Push to current branch
     - Re-run only the failed workflow: `gh run rerun <run-id> --failed`
     - Wait for workflow completion: `gh run watch <run-id>`
     - If workflow still fails, repeat the fixing steps
   - Continue process until all workflows pass

## Checklist
- [ ] Current branch and all workflows checked
- [ ] Waiting for in-progress workflows completed
- [ ] Failed workflows and details identified
- [ ] User permission obtained for commit/push
- [ ] Fixes applied and committed
- [ ] Workflows rerun and watched to completion
- [ ] All workflows pass

