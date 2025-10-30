# Auto-Fix Project Based on GitHub Workflow Failures

## Overview
This command analyzes failed GitHub workflow runs and automatically fixes the issues causing failures. It iterates through failed workflows, identifies problems, applies fixes, commits changes, and re-runs workflows until all pass.

## Common

- Use `gh` CLI command to work with GitHub workflows

### Key Commands
- List all workflows: `gh workflow list`
- Check last run for specific workflow: `gh run list --workflow=<workflow-name> --limit 1`
- View workflow run details: `gh run view <run-id>`
- View failed jobs: `gh run view <run-id> --log-failed`
- Re-run failed jobs: `gh run rerun <run-id> --failed`
- Check workflow status: `gh run watch <run-id>`

## Steps
1. **Check and prepare**
   - Get current branch: `git branch --show-current`
   - List all defined workflows: `gh workflow list`
   - For each workflow, check last run status: `gh run list --workflow=<workflow-name> --limit 1`
   - Identify workflows with failed runs and collect their run IDs
   - For each failed run: `gh run view <run-id> --log-failed` to see error details
   - Provide summary: total workflows, which ones passed, which ones failed, which ones never ran
   - If more than one workflow fails, ask user which workflow we will work with (Single workflow, All workflows)

2. **Request user for permission**
   - Provide information about current git project branch, committed/unstaged changes, etc.
   - Agent needs commit and push permission without confirmation.
   - Explicitly ask user about commit and push permission

3. **Fixing**
   - Analyze error logs from failed jobs
   - Apply fixes to project files
   - Commit changes with descriptive message
   - Push to current branch
   - Re-run failed workflows: `gh run rerun <run-id> --failed`
   - Monitor with: `gh run watch <run-id>`
   - Repeat until all workflows pass
