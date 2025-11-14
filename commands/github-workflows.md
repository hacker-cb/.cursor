# Manage GitHub Workflows

## Overview
Manage GitHub workflow runs with three operational modes: check status, auto-fix failures, or watch running workflows. Choose your workflow based on what you need to accomplish.

## Determine Workflow Based on User Choice

Ask user: "What would you like to do? [check/fix/watch]"

**CHECK** - Quick status report without waiting or modifications:
- Shows all workflow runs for current branch/commit
- Lists defined workflows and their status
- Reports passed/failed/running summary
- Exits immediately (no waiting, no fixes)

**FIX** - Complete automated fix cycle:
- Waits for running workflows to complete
- Creates fix branch if failures exist
- Applies fixes iteratively until all pass
- Triggers workflows if none exist
- Handles merge or PR creation at end

**WATCH** - Monitor running workflows until completion:
- Identifies currently running workflows
- Waits for all to complete
- Reports final pass/fail summary
- No fixes applied

Route to appropriate flow based on user selection.

## Common

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

## Common Functions

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

---

## CHECK Flow

Quick status check without any modifications or waiting.

### 1. Check workflows from current branch/commit
- Get current branch: `git branch --show-current`
- Get current commit: `git rev-parse HEAD`
- Check workflow runs for current branch/commit: `gh run list --branch=$(git branch --show-current) --commit=$(git rev-parse HEAD)`
- For each run: identify status (in progress, failed, or passed)
- Do not wait for running workflows (just report status)

### 2. List all defined workflows
- List all workflows: `gh workflow list`
- Compare defined workflows vs runs found
- Identify which workflows have runs and which don't

### 3. Show status summary
- Total workflows defined
- Workflows with runs vs without runs
- Which workflows passed
- Which workflows failed
- Which workflows are currently running
- For failed workflows: show run IDs for reference

### 4. Exit with report
- Provide complete summary
- Exit without any modifications
- No waiting for running workflows
- No triggering of workflows
- No fixes applied

---

## FIX Flow

Complete automated fix cycle for workflow failures.

### 1. Check workflows from current branch/commit
- Get current branch: `git branch --show-current`
- Get current commit: `git rev-parse HEAD`
- Check workflow runs for current branch/commit: `gh run list --branch=$(git branch --show-current) --commit=$(git rev-parse HEAD)`
- List all defined workflows: `gh workflow list`
- If workflow runs exist, identify status: in progress, failed, or passed
- Provide a summary: total workflows, which passed, which failed, which are running
- If more than one workflow fails, ask user which workflow to prioritize (Single workflow, All workflows)

### 2. Wait for running workflows if any
- If any workflow is still running, use `gh run watch <run-id>` to wait for completion before analyzing results
- For each failed run after completion: `gh run view <run-id> --log-failed` to view error details
- Update summary with final results

### 3. Check for uncommitted changes
- Check for uncommitted changes: `git status --porcelain`
- If uncommitted changes exist, refuse and ask user to commit or stash first
- This check ensures safe operation before any modifications

### 4. Handle workflow runs based on status
- **If workflow runs exist and all passed:**
  - Task complete - no fixes needed
  - Exit successfully
- **If workflow runs exist with failures:**
  - Call: [Create Fix Branch and Apply Fixes](#create-fix-branch-and-apply-fixes)
  - Proceed to step 5
- **If no workflow runs exist for current branch/commit:**
  - Call: [Ensure Manual Trigger Capability](#ensure-manual-trigger-capability) (on current branch)
  - Manually trigger each workflow: `gh workflow run <workflow-name> --ref <branch-name>`
  - Wait for each workflow completion: `gh run watch <run-id>`
  - Check results and identify any failures
  - If failures found:
    - Call: [Create Fix Branch and Apply Fixes](#create-fix-branch-and-apply-fixes)
    - Proceed to step 5
  - If all workflows pass: task complete - exit successfully

### 5. Merge or Create PR
- After all workflows pass, ask user: "All workflows pass. Would you like to: a) Merge branch directly back, or b) Create a Pull Request?"
- If user chooses merge directly:
  - Ask user about merge strategy: "Do you want to: a) Merge commit (--no-ff) to preserve branch history, or b) Squash merge to combine commits into one?"
  - Switch back to original branch (master, main, devel, or develop)
  - If merge commit chosen (or default): `git merge --no-ff <autofix-branch>`
  - If squash merge chosen: `git merge --squash <autofix-branch>` then `git commit -m "fix: resolve workflow failures"`
  - Push to remote
  - Delete autofix branch: `git branch -d <autofix-branch>`
- If user chooses create PR:
  - Create pull request with summary of fixes: `gh pr create --title "Auto-fix workflow failures" --body "<summary>"`
  - Provide PR URL to user

---

## WATCH Flow

Monitor running workflows until completion without applying fixes.

### 1. Check for workflow runs on current branch/commit
- Get current branch: `git branch --show-current`
- Get current commit: `git rev-parse HEAD`
- Check workflow runs for current branch/commit: `gh run list --branch=$(git branch --show-current) --commit=$(git rev-parse HEAD)`
- List all defined workflows: `gh workflow list`

### 2. Identify running workflows
- Filter workflow runs to find those with status "in progress"
- If no workflows are running:
  - Report: "No workflows currently running for this branch/commit"
  - Ask: "Would you like to trigger workflows? [Y/n]"
  - If Yes: trigger workflows and proceed to step 3
  - If No: exit
- Display running workflow names and run IDs

### 3. Wait for all running workflows
- For each running workflow:
  - Use `gh run watch <run-id>` to wait for completion
  - Display progress as workflows complete
- Continue until all workflows finish

### 4. Report final results
- Show final status for each workflow
- Count passed vs failed
- For failed workflows:
  - Show run IDs
  - Provide command to view logs: `gh run view <run-id> --log-failed`
- Summary: "X workflows passed, Y workflows failed"

### 5. Exit
- No fixes applied
- Suggest running FIX flow if failures exist
- Exit successfully

---

## Checklist

### Common (All Flows)
- [ ] User flow choice obtained (check/fix/watch)
- [ ] Current branch and commit identified
- [ ] Workflow runs checked for current branch/commit

### CHECK Flow
- [ ] All defined workflows listed
- [ ] Status summary provided (passed/failed/running)
- [ ] Report displayed without modifications

### FIX Flow
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

### WATCH Flow
- [ ] Running workflows identified
- [ ] All running workflows watched to completion
- [ ] Final results reported (pass/fail summary)
- [ ] FIX flow suggested if failures exist

