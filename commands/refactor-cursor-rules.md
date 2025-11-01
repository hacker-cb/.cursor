# Refactor Cursor Rules

## Overview
Analyze project tech stack and refactor project-specific cursor rules in `.cursor/rules/`. Validates rules against current codebase reality, preserves valuable guidance, and maintains rule quality and relevance.

## Steps

### 1. Verify Git Repository
- Check for `.git` directory in project root
- Verify project is under git version control
- If not a git repository:
  - Exit with error: "Project must be under git version control"
  - Explain git is required for file tracking
- Verify `git ls-files` returns tracked files

### 2. Refresh Agent Context with Current Rules
- Re-read all existing rules from `.cursor/rules/` directory
- Load current rule content into agent context
- Ensures agent has fresh understanding of current rules
- Necessary for accurate analysis and refactoring
- If `.cursor/rules/` doesn't exist: note and continue (will be created)

### 3. Check Shared Rules Present
- List all `shared-*.mdc` files in `.cursor/rules/`
- If no shared rules found:
  - Explain shared rules are required foundation
  - Ask: "Run sync-shared-rules to get shared rules now? [Y/n]"
  - If Yes: run sync-shared-rules command, wait for completion
  - If No: exit with error (shared rules required for refactoring)
- If shared rules present: proceed
- Note: shared rules won't be modified (synced from workspace)

### 4. Check for Deprecated .cursorrules File
- Search for `.cursorrules` file (deprecated format)
- Use `find . -name ".cursorrules" -type f`
- If found:
  - Notify user about deprecated format
  - Ask: "Delete deprecated .cursorrules file? [Y/n]"
  - If Yes: delete file
  - Note migration to `.cursor/rules/*.mdc` format

### 5. Check for Nested .cursor/rules Directories
- Search for `.cursor/rules/` in subdirectories
- Use `find . -type d -path "*/.cursor/rules" ! -path "./.cursor/rules"`
- If found:
  - Notify user with list of locations
  - Ask: "What to do? [M]erge to root, [D]elete nested, [S]kip"
  - Execute user decision
  - Wait for completion before proceeding

### 6. Find and Categorize All Rules
List all `.mdc` files in `.cursor/rules/` and categorize:
- **Shared rules:** `shared-*.mdc` (from workspace, read-only)
- **Local rules:** `local-*.mdc` (project-specific, will refactor)
- **Old rules:** Without prefix (need migration)
- Display count for each category

### 7. Detect Project Tech Stack
- Use `git ls-files` to get tracked files only
- **Detect project architecture:**
  - Multiple dependency manifests in subdirectories
  - Distinct directory structures (backend/, frontend/, platforms/, apps/)
  - Multiple build configurations or toolchains
  - Determine: single-module, multi-platform, or multi-module
- Scan dependency manifests per module/platform
- Identify primary languages per module/platform
- Count files by language per module/platform
- List build tools and frameworks per module/platform
- Detect project structure from tracked files
- Create tech stack summary (overall + per-module/platform if applicable)
- Ignore generated, vendor, and dependency files

### 8. Confirm Project Structure and Naming Policy
Present detected structure to user:
- **Project architecture:** Single-module, multi-platform, or multi-module
- **If multi-platform:** List detected platforms/components
- **If multi-module:** List detected modules
- **Detected structure:** Show directory organization
- Ask user to confirm or correct structure understanding
- **Naming policy:** Follow conventions from shared-rules-management.mdc
  - Multi-platform: platform-first naming
  - Multi-module: aspect-first naming
  - Single-module: topic or language-topic naming
  - Hybrid: use both as appropriate
- Ask user which pattern fits this project
- Document agreed convention for consistency
- User confirmation required before proceeding

### 9. Migrate Old Rules to New Naming
For each file without `shared-` or `local-` prefix:
- Analyze content to determine purpose and module/platform
- Suggest name using agreed naming convention from Step 8
- Follow patterns from shared-rules-management.mdc
- Ask: "Rename {old}.mdc to {suggested}.mdc? [Y/n/e]dit"
- Allow user to edit suggested name
- Rename approved files
- Track migrations for report

### 10. Analyze Current Codebase Practices
Sample and analyze tracked project code:
- Use `git ls-files` as source of truth
- **If multi-module project:**
  - Analyze each module/platform separately
  - Sample 20-30 files per language per module
  - Extract conventions per module (may differ between modules)
  - Identify module-specific patterns
  - Note module boundaries and organization
- **If single-module:**
  - Sample across entire project
  - Extract project-wide conventions
- Identify code organization patterns
- Detect testing approaches in tracked tests
- Review build configuration
- Document actual practices (per-module or project-wide)
- Skip generated files, dependencies, vendor directories

### 11. Analyze Existing Local Rules
For each `local-*.mdc` file:
- Read current guidance documented
- Extract tech-specific conventions
- Identify valuable project-specific practices
- Note which parts reflect current state
- Find potentially outdated guidance
- Preserve useful patterns worth keeping

### 12. Validate Rules Against Reality
Compare each local rule to actual tracked codebase:
- Tech stack references: still accurate?
- Frameworks/libraries: still in use?
- File globs: match actual tracked file structure?
- Tags: reflect current technologies?
- Examples: match actual code patterns in tracked files?
- Conventions: match real codebase patterns?
- **For multi-module projects:**
  - Check if module-specific rules exist per module
  - Verify globs target correct module directories
  - Find modules without dedicated rules
  - Check if rules reflect per-module differences
- Identify: obsolete rules, incorrect rules, valuable rules
- Find gaps: technologies or modules without rules

### 13. Present Refactoring Plan
Show comprehensive plan to user:
- **Tech stack:** Detected from tracked files vs documented
- **Shared rules:** Count (won't modify)
- **Local rules to refactor:** List with planned changes
  - Keep as-is (current and accurate)
  - Update (specific outdated items)
  - Remove (obsolete technology)
  - Consolidate (duplicates)
- **Metadata corrections:** Globs and tags to fix
- **New rules suggested:** For gaps found
- Ask: "Proceed with refactoring? [Y/n]"
- If No: exit without changes

### 14. Refactor Local Rules
With user confirmation, update each `local-*.mdc`:
- **Preserve valuable guidance** from existing
- Update tech references to current stack
- Remove obsolete technology sections
- Update patterns to match current codebase
- Consolidate duplicate content
- Add guidance for new technologies
- Ensure rules match project reality
- Target 50-150 lines (max 300)

**Never modify `shared-*.mdc` files**

### 15. Update Metadata
For each refactored local rule:
- Update globs to match tracked file structure
- Test globs with `git ls-files` to verify matches
- Update tags to current technologies
- Ensure metadata accurate for tracked files
- Verify rules trigger appropriately

### 16. Suggest and Create New Rules
For gaps in coverage:
- Suggest new `local-*.mdc` files for missing technologies/modules
- Follow agreed naming convention from Step 8
- Follow patterns from shared-rules-management.mdc
- Ask which suggestions to create
- Create basic structure for approved
- User fills details later

### 17. Validate and Save
- Verify metadata syntax
- Test globs against tracked files
- Check naming conventions
- Ensure valuable guidance preserved
- Verify shared rules untouched
- Save all changes

### 18. Recommend New Agent Session
After refactoring complete:
- Inform user: "Rules have been refactored"
- Recommend: "Start a new agent session to use updated rules"
- Explain: "Current agent loaded old rules at session start"
- Note: "New session will load fresh refactored rules into context"

### 19. Generate Report
- Tech stack from tracked files
- Shared rules: count (unchanged)
- Local rules: changes per file
- Migrations: old to new names
- Removals: names and reasons
- Metadata: globs and tags corrected
- New rules: created
- Recommendation to start new agent session
- Next steps

## Checklist

- [ ] Git repository verified
- [ ] Agent context refreshed with current rules
- [ ] Shared rules checked (sync if missing)
- [ ] Deprecated .cursorrules handled
- [ ] Nested directories resolved
- [ ] Rules categorized
- [ ] Old rules migrated
- [ ] Tech stack detected from tracked files
- [ ] Project structure and naming policy confirmed
- [ ] Codebase practices analyzed from tracked code
- [ ] Existing rules analyzed
- [ ] Rules validated against tracked codebase
- [ ] Plan presented
- [ ] User confirmation received
- [ ] Local rules refactored
- [ ] Metadata updated
- [ ] New rules suggested
- [ ] Results validated and saved
- [ ] New agent session recommended
- [ ] Report generated
