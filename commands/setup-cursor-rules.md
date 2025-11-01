# Setup Cursor Rules

## Overview
Analyze project and setup cursor rules in `.cursor/rules/`. For new projects: generates rules from scratch based on detected patterns. For existing projects: validates and refactors rules against current codebase. Handles both initialization and ongoing maintenance.

## Steps

### 1. Verify Git Repository
- Check for `.git` directory in project root
- Verify project is under git version control
- Exit if not git repository
- Verify `git ls-files` returns tracked files

### 2. Check for Existing Rules
- List all `.mdc` files in `.cursor/rules/` (if directory exists)
- Categorize:
  - **Shared rules:** `shared-*.mdc` (from workspace)
  - **Local rules:** `local-*.mdc` (project-specific)
  - **Old rules:** Without prefix
- Determine workflow:
  - **If no local rules:** INIT flow (generate from scratch)
  - **If has local rules:** REFACTOR flow (validate and update)

### 3. Check Shared Rules Present
- List all `shared-*.mdc` files in `.cursor/rules/`
- If no shared rules found:
  - Explain shared rules are required foundation
  - Ask: "Run sync-shared-rules now? [Y/n]"
  - If Yes: run sync, wait for completion
  - If No: exit (shared rules required)
- If shared rules present: proceed

### 4. Check for Deprecated .cursorrules File
- Search for `.cursorrules` (deprecated format)
- If found: ask to delete, migrate to `.cursor/rules/*.mdc`

### 5. Check for Nested .cursor/rules Directories
- Search for `.cursor/rules/` in subdirectories
- If found: ask to merge/delete/skip
- Ensure single rules directory at root

---

## INIT Flow (No Local Rules)

### 6A. Detect Project Tech Stack
- Use `git ls-files` for tracked files only
- Detect architecture: single-module, multi-platform, or multi-module
- Scan dependency manifests per module/platform
- Identify primary languages per module/platform
- List build tools and frameworks
- Create tech stack summary

### 7A. Analyze Code Patterns
Sample tracked code (20-30 files per language per module):
- Naming conventions (variables, functions, classes)
- Project structure and organization
- Architecture style
- Testing approaches
- Error handling patterns
- Code formatting
- Per-module if multi-module

### 8A. Confirm Structure and Naming Policy
- Present detected architecture
- List modules/platforms if applicable
- Show detected structure
- Ask user to confirm
- Present naming policy options from shared-rules-management.mdc
- Ask user which pattern to use
- Document agreed convention

### 9A. Present Generation Plan
- Tech stack detected
- Modules/platforms identified
- Patterns found
- Local rules to generate (list with naming)
- Ask confirmation to proceed

### 10A. Generate Local Rules
Create `local-*.mdc` files following confirmed naming:
- Per language/framework rules
- Per module/platform rules if applicable
- Architecture and structure rules
- Testing conventions
- Code style rules
- Use YAML frontmatter with tags and globs
- Base on actual code patterns
- 50-150 lines per rule (max 300)

### 11A. Validate Generated Rules
- Verify metadata syntax
- Test globs match tracked files
- Check naming follows convention
- Verify tags accurate
- Save all generated files

### 12A. Generate Report
- Tech stack summary
- Shared rules synced
- Local rules generated (list)
- Patterns documented
- Next steps: review and refine rules

---

## REFACTOR Flow (Has Local Rules)

### 6B. Refresh Agent Context
- Re-read all existing rules
- Load into agent context
- Ensures fresh understanding

### 7B. Migrate Old Rules
- For files without prefix: suggest `local-` names
- Follow confirmed naming convention
- Ask user approval for each

### 8B. Detect Project Tech Stack
- Same as 6A (detect from tracked files)

### 9B. Confirm Structure and Naming Policy
- Same as 8A (confirm with user)

### 10B. Analyze Current Codebase
- Sample tracked code per module/platform
- Extract actual conventions
- Document practices found

### 11B. Analyze Existing Local Rules
- Read current guidance
- Identify valuable practices
- Find outdated guidance

### 12B. Validate Against Reality
- Compare rules to actual code
- Check tech stack still accurate
- Verify globs match structure
- Find obsolete rules
- Identify gaps

### 13B. Present Refactoring Plan
- Tech stack vs documented
- Rules to update/remove/consolidate
- Metadata corrections
- New rules suggested
- Ask confirmation

### 14B. Refactor Local Rules
- Preserve valuable guidance
- Update to current reality
- Remove obsolete sections
- Target 50-150 lines

### 15B. Update Metadata
- Fix globs for tracked files
- Update tags
- Test with git ls-files

### 16B. Suggest New Rules
- For gaps found
- Follow naming convention

### 17B. Validate and Save
- Verify all changes
- Save updates

### 18B. Recommend New Session
- Inform rules refactored
- Recommend new agent session

### 19B. Generate Report
- Changes made
- Migrations
- Removals
- New rules created

## Checklist

### Both Flows
- [ ] Git repository verified
- [ ] Shared rules checked/synced
- [ ] Deprecated .cursorrules handled
- [ ] Nested directories resolved
- [ ] Existing rules checked

### Init Flow
- [ ] Tech stack detected
- [ ] Code patterns analyzed
- [ ] Structure and naming confirmed
- [ ] Generation plan presented
- [ ] User confirmation received
- [ ] Local rules generated
- [ ] Rules validated
- [ ] Report generated

### Refactor Flow
- [ ] Agent context refreshed
- [ ] Old rules migrated
- [ ] Tech stack detected
- [ ] Structure and naming confirmed
- [ ] Codebase analyzed
- [ ] Existing rules analyzed
- [ ] Rules validated against reality
- [ ] Refactoring plan presented
- [ ] User confirmation received
- [ ] Local rules refactored
- [ ] Metadata updated
- [ ] New rules suggested
- [ ] Changes validated
- [ ] New session recommended
- [ ] Report generated

