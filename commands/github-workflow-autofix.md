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
- Check for uncommitted changes: `git status --porcelain`
- Create fix branch: `git checkout -b <branch-name>`
- Create pull request: `gh pr create`

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

2. **Create fix branch**
   - Check for uncommitted changes: `git status --porcelain`
   - If uncommitted changes exist, refuse and ask user to commit or stash first
   - Analyze error details from failed workflows to generate meaningful branch name
   - Create branch name based on error context (e.g., `autofix/lint-errors`, `autofix/test-timeout`)
   - If error context not clear, use generic pattern: `autofix/workflow-failures-YYYYMMDD`
   - Create and checkout new branch: `git checkout -b <branch-name>`

3. **Request user permission**
   - Provide status on autofix branch created
   - State agent will work in the autofix branch (not original branch)
   - State agent requires permission to create branch, commit, and push fixes
   - Request explicit user permission to proceed

4. **Fixing Loop**
   - For each failed workflow:
     - Analyze error logs from failed jobs
     - Apply fixes to project files in the autofix branch
     - Commit changes with a descriptive message
     - Push to the autofix branch
     - Re-run only the failed workflow: `gh run rerun <run-id> --failed`
     - Wait for workflow completion: `gh run watch <run-id>`
     - If workflow still fails, repeat the fixing steps
   - Continue process until all workflows pass

5. **Merge or Create PR**
   - After all workflows pass, ask user: "All workflows pass. Would you like to: a) Merge branch directly back, or b) Create a Pull Request?"
   - If user chooses merge directly:
     - Switch back to original branch
     - Merge autofix branch: `git merge <autofix-branch>`
     - Push to remote
     - Delete autofix branch: `git branch -d <autofix-branch>`
   - If user chooses create PR:
     - Create pull request with summary of fixes: `gh pr create --title "Auto-fix workflow failures" --body "<summary>"`
     - Provide PR URL to user

## Checklist
- [ ] Current branch and all workflows checked
- [ ] Waiting for in-progress workflows completed
- [ ] Failed workflows and details identified
- [ ] Uncommitted changes checked
- [ ] Fix branch created with meaningful name
- [ ] User permission obtained for branch creation and commits
- [ ] Fixes applied and committed to autofix branch
- [ ] Workflows rerun and watched to completion
- [ ] All workflows pass
- [ ] User choice for merge/PR obtained
- [ ] Branch merged or PR created

