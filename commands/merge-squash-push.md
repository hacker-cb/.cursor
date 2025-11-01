# Merge Squash Push

## Overview
Interactive squash merge workflow with automatic base branch detection, change summary, and confirmation prompts. Follows git workflow standards for clean commit history.

## Steps

### 1. Detect Base Branch
- Try upstream branch: `git rev-parse --abbrev-ref @{upstream}`
- Check reflog for branch origin: `git reflog show <branch> | grep "branch:"`
- Look for: master, main, develop, dev
- If detection fails, ask user which branch to merge into

### 2. Pre-merge Validation
- Verify current branch is feature branch (not base branch)
- Check commits ahead of base branch
- Verify clean working directory
- Fetch latest from remote
- Check base branch sync status
- Warn if base branch behind remote

### 3. Show Change Summary
- Display branch names and commit count
- Show commit history vs base branch
- List files changed with statistics
- Highlight dependency or config changes
- Show test additions/modifications

### 4. Pre-merge Checks
- Run tests if configured
- Check linter status
- Validate no merge conflicts
- Warn about large changesets

### 5. User Confirmation
- Present change summary
- Ask: "Proceed with squash merge? (yes/no)"
- If no, abort with resume instructions

### 6. Commit Message
- Prompt for conventional commit message per git workflow standards
- Validate format
- Ask for optional body
- Confirm message: "Use this? (yes/no/edit)"

### 7. Execute Merge
- Checkout base branch
- Pull latest from remote
- Squash merge: `git merge --squash <feature-branch>`
- Commit with provided message
- Show merge result

### 8. Push
- Ask: "Push to origin/<base-branch>? (yes/no)"
- Push if confirmed
- Show result or manual push command

### 9. Cleanup
- Ask to delete local feature branch
- Ask to delete remote feature branch
- Execute deletions if confirmed
- Return to base branch

### 10. Verification
- Confirm on base branch
- Show latest commit
- Display sync status
- List any pending actions

## Checklist
- [ ] Base branch detected or selected
- [ ] On feature branch (not base branch)
- [ ] No uncommitted changes
- [ ] Change summary displayed
- [ ] Tests passing
- [ ] User confirmed changes
- [ ] Conventional commit message provided
- [ ] Commit message validated
- [ ] Squash merge completed
- [ ] Changes pushed to remote
- [ ] Feature branch cleaned up
- [ ] Verification successful
- [ ] Back on base branch

