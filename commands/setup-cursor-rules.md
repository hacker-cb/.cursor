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
  - **Old rules:** Without prefix (require migration)
- Determine workflow:
  - **If no local rules and no old rules:** INIT flow (generate from scratch)
  - **If has local rules:** REFACTOR flow (validate and update)
  - **If has old rules only:** OLD RULES flow (analyze, refactor, migrate)

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

### 6. Refresh Context and Handle Mixed Rules
- Re-read all existing local rules
- Load into agent context for fresh understanding
- If old rules (without prefix) also exist:
  - Note their presence for deeper analysis
  - Will analyze alongside local rules in step 9
  - Will suggest migration in step 10

### 7. Detect Current State
- Call: [Detect Tech Stack](#detect-tech-stack)
- Call: [Analyze Code Patterns](#analyze-code-patterns)
- Document current project state

### 8. Confirm with User
- Call: [Confirm Structure and Naming Policy](#confirm-structure-and-naming-policy)
- Verify understanding matches reality

### 9. Compare Rules to Reality
- Analyze existing local rules content
- If old rules exist: analyze their content too
- Identify valuable practices worth keeping
- Compare rules to actual code patterns
- Check tech stack still matches documented
- Verify globs still match project structure
- Find obsolete or outdated guidance
- Identify coverage gaps (missing rules)
- For old rules: determine migration strategy

### 10. Present Refactoring Plan
- Tech stack changes vs documented
- Rules to update with specific changes
- Rules to remove or consolidate
- Metadata corrections needed (globs, tags)
- New rules to create for gaps
- If old rules exist: migration plan (rename, refactor, split)
- Ask user confirmation to proceed

### 11. Refactor Local Rules
- Preserve valuable guidance that's still relevant
- Update rules to match current code reality
- Remove obsolete sections and outdated practices
- Fix metadata (globs, tags) for accuracy
- Create new rules for identified gaps
- If old rules exist: migrate to proper `local-*` naming and delete old files
- Target 50-150 lines per rule (max 300 if comprehensive)

### 12. Validate, Report, and Recommend
- Call: [Validate Generated Rules](#validate-generated-rules)
- Call: [Generate Report](#generate-report)
- Recommend starting new agent session to load updated rules

---

## OLD RULES Flow (Has Old Rules Without Prefix)

Deep analysis and refactoring of rules without proper naming prefix.

### 6. Analyze Old Rules Content
- Read all old rule files (without `local-` or `shared-` prefix)
- Categorize content by domain:
  - Language/framework-specific guidance
  - Architecture and structure patterns
  - Testing conventions
  - Code style and formatting
  - Project-specific vs universal guidance
- Identify valuable vs outdated content
- Check for mixed content that should be split

### 7. Detect Current Project State
- Call: [Detect Tech Stack](#detect-tech-stack)
- Call: [Analyze Code Patterns](#analyze-code-patterns)
- Document current codebase reality

### 8. Compare Old Rules to Current Reality
- Match old rules content to current code patterns
- Identify still-relevant guidance worth preserving
- Find outdated practices no longer used
- Detect mismatches with current tech stack
- Check if globs/tags still accurate
- Find content better suited for shared rules

### 9. Confirm with User
- Call: [Confirm Structure and Naming Policy](#confirm-structure-and-naming-policy)
- Present findings from old rules analysis
- Show what's still relevant vs outdated

### 10. Present Migration and Refactoring Plan
- Old rules content breakdown
- Guidance worth preserving with rationale
- Outdated content to remove with explanation
- Suggested new file structure with proper naming
- Content to split into multiple files
- Content to consolidate
- Potential shared rules candidates
- Ask user confirmation to proceed

### 11. Refactor and Migrate
- Create new `local-*.mdc` files with proper naming
- Preserve valuable guidance from old rules
- Update content to match current codebase
- Remove outdated and irrelevant sections
- Split mixed content into focused files
- Add proper YAML frontmatter (tags, globs)
- Ensure 50-150 lines per rule (max 300)
- Delete old rule files after successful migration

### 12. Validate, Report, and Recommend
- Call: [Validate Generated Rules](#validate-generated-rules)
- Call: [Generate Report](#generate-report)
- Show migration summary (old → new mapping)
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

### OLD RULES Flow
- [ ] Old rules content analyzed
- [ ] Content compared to current codebase
- [ ] Valuable content identified
- [ ] Outdated content identified
- [ ] Migration plan approved
- [ ] New local rules created
- [ ] Old rules deleted
- [ ] Migration summary provided
- [ ] New session recommended
