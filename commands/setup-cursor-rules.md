# Setup Cursor Rules

## Overview
Analyze project and setup cursor rules in `.cursor/rules/`. For new projects: generates rules from scratch based on detected patterns. For existing projects: validates and refactors rules against current codebase. Handles both initialization and ongoing maintenance.

## Common Steps

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

## Common Functions

These functions are used by both INIT and REFACTOR flows.

### Detect Tech Stack
- Use `git ls-files` for tracked files only
- Detect architecture: single-module, multi-platform, or multi-module
- Scan dependency manifests per module/platform
- Identify primary languages per module/platform
- List build tools and frameworks
- Create tech stack summary

### Analyze Code Patterns
Sample tracked code (20-30 files per language per module):
- Naming conventions (variables, functions, classes)
- Project structure and organization
- Architecture style (MVC, layered, microservices)
- Testing approaches and patterns
- Error handling and logging patterns
- Code formatting and style

### Confirm Structure and Naming Policy
- Present detected architecture
- List modules/platforms if applicable
- Show detected structure
- Ask user to confirm accuracy
- Present naming policy options from shared-rules-management.mdc
- Ask user which pattern to use (local-*, module-name-*, platform-*, feature-*)
- Document agreed convention

### Validate Generated Rules
- Verify YAML frontmatter syntax correct
- Test globs match tracked files with `git ls-files`
- Check naming follows agreed convention
- Verify tags accurate for file targeting
- Ensure 50-150 lines per rule (max 300 if needed)
- Save all rule files

### Generate Report
- Tech stack summary
- Shared rules status
- Local rules created/updated (list with descriptions)
- Patterns documented
- Issues found and resolved
- Next steps and recommendations

---

## INIT Flow (No Local Rules)

Generate rules from scratch based on project analysis.

### 6. Detect and Analyze Project
- Call: [Detect Tech Stack](#detect-tech-stack)
- Call: [Analyze Code Patterns](#analyze-code-patterns)
- Document findings for rule generation

### 7. Confirm with User
- Call: [Confirm Structure and Naming Policy](#confirm-structure-and-naming-policy)
- Get user approval before generation

### 8. Present Generation Plan
- Tech stack detected (languages, frameworks, tools)
- Architecture identified (modules, platforms, structure)
- Local rules to generate with proposed names
- Patterns to document (naming, testing, style)
- Ask confirmation to proceed

### 9. Generate Local Rules
Create `local-*.mdc` files following confirmed naming:
- Per language/framework rules (e.g., `local-python.mdc`, `local-typescript.mdc`)
- Per module/platform rules if multi-module (e.g., `local-backend.mdc`, `local-frontend.mdc`)
- Architecture and structure rules (e.g., `local-architecture.mdc`)
- Testing conventions (e.g., `local-testing.mdc`)
- Code style and formatting (e.g., `local-style.mdc`)
- Use YAML frontmatter with appropriate tags and globs
- Base rules on actual code patterns found

### 10. Validate and Report
- Call: [Validate Generated Rules](#validate-generated-rules)
- Call: [Generate Report](#generate-report)
- Recommend reviewing and refining generated rules

---

## REFACTOR Flow (Has Local Rules)

Validate and update existing rules against current codebase.

### 6. Refresh Context and Migrate
- Re-read all existing local rules
- Load into agent context for fresh understanding
- For files without prefix: suggest `local-` names
- Follow confirmed naming convention
- Ask user approval for each migration

### 7. Detect Current State
- Call: [Detect Tech Stack](#detect-tech-stack)
- Call: [Analyze Code Patterns](#analyze-code-patterns)
- Document current project state

### 8. Confirm with User
- Call: [Confirm Structure and Naming Policy](#confirm-structure-and-naming-policy)
- Verify understanding matches reality

### 9. Compare Rules to Reality
- Analyze existing local rules content
- Identify valuable practices worth keeping
- Compare rules to actual code patterns
- Check tech stack still matches documented
- Verify globs still match project structure
- Find obsolete or outdated guidance
- Identify coverage gaps (missing rules)

### 10. Present Refactoring Plan
- Tech stack changes vs documented
- Rules to update with specific changes
- Rules to remove or consolidate
- Metadata corrections needed (globs, tags)
- New rules to create for gaps
- Ask user confirmation to proceed

### 11. Refactor Local Rules
- Preserve valuable guidance that's still relevant
- Update rules to match current code reality
- Remove obsolete sections and outdated practices
- Fix metadata (globs, tags) for accuracy
- Create new rules for identified gaps
- Target 50-150 lines per rule (max 300 if comprehensive)

### 12. Validate, Report, and Recommend
- Call: [Validate Generated Rules](#validate-generated-rules)
- Call: [Generate Report](#generate-report)
- Recommend starting new agent session to load updated rules

---

## Checklist

### Common (All Flows)
- [ ] Git repository verified
- [ ] Existing rules categorized
- [ ] Shared rules present/synced
- [ ] Deprecated files handled
- [ ] Nested directories resolved
- [ ] Tech stack detected
- [ ] Code patterns analyzed
- [ ] Structure and naming confirmed

### INIT Flow
- [ ] Generation plan approved
- [ ] Local rules generated
- [ ] Rules validated
- [ ] Report provided

### REFACTOR Flow
- [ ] Old rules migrated
- [ ] Rules compared to reality
- [ ] Refactoring plan approved
- [ ] Local rules updated
- [ ] New rules created
- [ ] New session recommended
- [ ] Report provided
