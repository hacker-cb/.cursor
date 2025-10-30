# Create Pull Request

## Overview
Create a well-structured pull request with comprehensive description, proper metadata, and review checklist to facilitate smooth code review.

## Steps

### 1. Prepare Branch
- Ensure all changes are committed with clear messages
- Rebase on latest main/master/develop if needed
- Resolve any merge conflicts
- Push branch to remote repository
- Verify branch builds successfully
- Ensure all tests pass

### 2. Review Your Changes
- Review diff before creating PR
- Check for debug code or console logs
- Verify no unintended files included
- Ensure code follows project conventions
- Check for proper error handling
- Verify tests added for new functionality

### 3. Write PR Title
- Use clear, descriptive title
- Follow project conventions (e.g., [Feature], [Fix], [Docs])
- Keep under 72 characters
- Use imperative mood

### 4. Write PR Description
- Summarize changes clearly
- Explain context and motivation
- Describe solution approach
- List any breaking changes
- Add screenshots for UI changes
- Include testing performed
- Note any dependencies or blockers
- Reference related issues or PRs

### 5. Add Metadata
- Add appropriate labels (feature, bug, documentation)
- Assign reviewers based on code ownership
- Link related issues (Fixes #123, Relates to #456)
- Set milestone if applicable
- Add to project board if used
- Mark as draft if work-in-progress

### 6. Complete PR Checklist
- Verify tests pass in CI
- Check code coverage meets requirements
- Ensure linting passes
- Verify documentation updated
- Confirm no security issues
- Check performance impact
- Verify accessibility if UI changes

### 7. Request Review
- Tag specific reviewers if needed
- Notify team in chat if urgent
- Respond promptly to feedback
- Push additional commits for requested changes
- Re-request review after addressing feedback

### 8. Prepare for Merge
- Ensure all CI checks pass
- Obtain required approvals
- Resolve all review comments
- Update branch if main has changed
- Verify merge conflicts resolved
- Check final diff before merging

## PR Description Template

```markdown
## Summary
Brief description of changes

## Context
Why this change is needed

## Changes
- Change 1
- Change 2
- Change 3

## Breaking Changes
List any breaking changes or None

## Testing
Describe testing performed

## Screenshots
Add if UI changes

## Related
Fixes #issue-number
```

## Checklist

### Preparation
- [ ] All changes committed
- [ ] Branch rebased on latest main
- [ ] All tests passing locally
- [ ] Code reviewed by self
- [ ] No debug code left

### PR Creation
- [ ] Descriptive title written
- [ ] Comprehensive description added
- [ ] Related issues linked
- [ ] Appropriate labels added
- [ ] Reviewers assigned
- [ ] CI checks passing

### Review Process
- [ ] Feedback addressed
- [ ] Additional commits pushed
- [ ] Review re-requested
- [ ] All approvals obtained

### Merge Ready
- [ ] All checks passing
- [ ] Required approvals received
- [ ] Conflicts resolved
- [ ] Ready to merge