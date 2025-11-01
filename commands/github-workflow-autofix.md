# Auto-Fix Project Based on GitHub Workflow Failures

## Overview
This command analyzes GitHub workflow runs, watches for failed runs, and automatically applies fixes until all workflows pass. If any workflow is currently running, it waits for the result before proceeding, then handles failures iteratively.

## Common

- Use `gh` CLI command for working with GitHub workflows

### Key Commands
- List all workflows: `gh workflow list`
- Check runs for current branch/commit: `gh run list --branch=$(git branch --show-current) --commit=$(git rev-parse HEAD)`
- View workflow run details: `gh run view <run-id>`
- View failed jobs: `gh run view <run-id> --log-failed`
- Manually trigger workflow: `gh workflow run <workflow-name> --ref <branch-name>`
- Check workflow status (wait for completion): `gh run watch <run-id>`
- Check for uncommitted changes: `git status --porcelain`
- Create fix branch: `git checkout -b <branch-name>`
- Create pull request: `gh pr create`

## Steps
1. **Check workflows from current branch/commit**
   - Get current branch: `git branch --show-current`
   - Get current commit: `git rev-parse HEAD`
   - Check workflow runs for current branch/commit: `gh run list --branch=$(git branch --show-current) --commit=$(git rev-parse HEAD)`
   - List all defined workflows: `gh workflow list`
   - If workflow runs exist, identify status: in progress, failed, or passed
   - If any workflow is still running, use `gh run watch <run-id>` to wait for completion before analyzing results
   - For each failed run: `gh run view <run-id> --log-failed` to view error details
   - Provide a summary: total workflows, which passed, which failed, which are running
   - If more than one workflow fails, ask user which workflow to prioritize (Single workflow, All workflows)

2. **Check for uncommitted changes**
   - Check for uncommitted changes: `git status --porcelain`
   - If uncommitted changes exist, refuse and ask user to commit or stash first
   - This check ensures safe operation before any modifications

3. **Handle workflow runs based on status**
   - **If workflow runs exist and all passed:**
     - Task complete - no fixes needed
     - Exit successfully
   - **If workflow runs exist with failures:**
     - Call: [Create Fix Branch and Apply Fixes](#create-fix-branch-and-apply-fixes)
     - Proceed to step 4
   - **If no workflow runs exist for current branch/commit:**
     - Call: [Ensure Manual Trigger Capability](#ensure-manual-trigger-capability) (on current branch)
     - Manually trigger each workflow: `gh workflow run <workflow-name> --ref <branch-name>`
     - Wait for each workflow completion: `gh run watch <run-id>`
     - Check results and identify any failures
     - If failures found:
       - Call: [Create Fix Branch and Apply Fixes](#create-fix-branch-and-apply-fixes)
       - Proceed to step 4
     - If all workflows pass: task complete - exit successfully

4. **Merge or Create PR**
   - After all workflows pass, ask user: "All workflows pass. Would you like to: a) Merge branch directly back, or b) Create a Pull Request?"
   - If user chooses merge directly:
     - Switch back to original branch
     - Merge autofix branch: `git merge <autofix-branch>`
     - Push to remote
     - Delete autofix branch: `git branch -d <autofix-branch>`
   - If user chooses create PR:
     - Create pull request with summary of fixes: `gh pr create --title "Auto-fix workflow failures" --body "<summary>"`
     - Provide PR URL to user

## Functions

### Ensure Manual Trigger Capability
**Purpose:** Ensure all workflows can be manually triggered

**Steps:**
- Check each workflow file in `.github/workflows/` directory
- For each workflow, check for `workflow_dispatch` in the `on:` section
- If `workflow_dispatch` is missing:
  - Add it to enable manual triggering
  - Commit change: "Enable manual trigger for <workflow-name>"
  - Push to current branch

### Create Fix Branch and Apply Fixes
**Purpose:** Create a fix branch and iteratively fix workflow failures until all pass

**Steps:**
- Check current branch name: `git branch --show-current`
- **If already in autofix branch** (branch name starts with `autofix/`):
  - Stay on current branch - no need to create new one
  - Skip branch creation step
- **If not in autofix branch:**
  - Analyze error details from failed workflows to generate meaningful branch name
  - Create branch name based on error context (e.g., `autofix/lint-errors`, `autofix/test-timeout`)
  - If error context not clear, use generic pattern: `autofix/workflow-failures-YYYYMMDD`
  - Create and checkout new branch: `git checkout -b <branch-name>`
- **Ensure workflow_dispatch in fix branch:**
  - Check each workflow file in `.github/workflows/` directory
  - For each workflow, check for `workflow_dispatch` in the `on:` section
  - If `workflow_dispatch` is missing:
    - Add it to enable manual triggering
    - Commit change: "Enable manual trigger for <workflow-name>"
    - Push to fix branch
- **Fixing Loop:**
  - For each failed workflow:
    - Analyze error logs from failed jobs
    - Apply fixes to project files in the autofix branch
    - Commit changes with a descriptive message
    - Push to the autofix branch
    - Trigger workflow on fix branch: `gh workflow run <workflow-name> --ref <autofix-branch>`
    - Wait for workflow completion: `gh run watch <run-id>`
    - If workflow still fails, repeat the fixing steps
  - Continue process until all workflows pass

## Checklist
- [ ] Current branch/commit workflows checked
- [ ] Waiting for in-progress workflows completed
- [ ] Uncommitted changes verified (early check)
- [ ] Manual triggers enabled if needed
- [ ] Workflows triggered if no runs exist
- [ ] Failed workflows and details identified
- [ ] Fix branch created with meaningful name
- [ ] Fixes applied and committed to autofix branch
- [ ] Workflows triggered on fix branch and watched to completion
- [ ] All workflows pass
- [ ] User choice for merge/PR obtained
- [ ] Branch merged or PR created

