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

### 2. Check Shared Rules Present
- List all `shared-*.mdc` files in `.cursor/rules/`
- If no shared rules found:
  - Explain shared rules are required foundation
  - Ask: "Run sync-shared-rules to get shared rules now? [Y/n]"
  - If Yes: run sync-shared-rules command, wait for completion
  - If No: exit with error (shared rules required for refactoring)
- If shared rules present: proceed
- Note: shared rules won't be modified (synced from workspace)

### 3. Check for Deprecated .cursorrules File
- Search for `.cursorrules` file (deprecated format)
- Use `find . -name ".cursorrules" -type f`
- If found:
  - Notify user about deprecated format
  - Ask: "Delete deprecated .cursorrules file? [Y/n]"
  - If Yes: delete file
  - Note migration to `.cursor/rules/*.mdc` format

### 4. Check for Nested .cursor/rules Directories
- Search for `.cursor/rules/` in subdirectories
- Use `find . -type d -path "*/.cursor/rules" ! -path "./.cursor/rules"`
- If found:
  - Notify user with list of locations
  - Ask: "What to do? [M]erge to root, [D]elete nested, [S]kip"
  - Execute user decision
  - Wait for completion before proceeding

### 5. Find and Categorize All Rules
List all `.mdc` files in `.cursor/rules/` and categorize:
- **Shared rules:** `shared-*.mdc` (from workspace, read-only)
- **Local rules:** `local-*.mdc` (project-specific, will refactor)
- **Old rules:** Without prefix (need migration)
- Display count for each category

### 6. Migrate Old Rules to New Naming
For each file without `shared-` or `local-` prefix:
- Analyze content to determine purpose
- Suggest name with `local-` prefix
- Pattern: `local-{module}-{topic}.mdc`
- Ask: "Rename {old}.mdc to {suggested}.mdc? [Y/n/e]dit"
- Allow user to edit suggested name
- Rename approved files
- Track migrations for report

### 7. Detect Project Tech Stack
- Use `git ls-files` to get tracked files only
- Scan dependency manifests (package.json, requirements.txt, etc.)
- Identify languages from tracked file extensions
- Count files by language to find primary languages
- List build tools and frameworks from manifests
- Detect project structure from tracked files
- Ignore generated, vendor, and dependency files
- Create tech stack summary from tracked files only

### 8. Analyze Current Codebase Practices
Sample and analyze tracked project code:
- Use `git ls-files` as source of truth
- Sample tracked source files only (20-30 per language)
- Extract naming conventions from actual code
- Identify code organization patterns
- Detect testing approaches in tracked tests
- Review build configuration in tracked files
- Document actual practices found in codebase
- Skip generated files, dependencies, vendor directories

### 9. Analyze Existing Local Rules
For each `local-*.mdc` file:
- Read current guidance documented
- Extract tech-specific conventions
- Identify valuable project-specific practices
- Note which parts reflect current state
- Find potentially outdated guidance
- Preserve useful patterns worth keeping

### 10. Validate Rules Against Reality
Compare each local rule to actual tracked codebase:
- Tech stack references: still accurate?
- Frameworks/libraries: still in use?
- File globs: match actual tracked file structure?
- Tags: reflect current technologies?
- Examples: match actual code patterns in tracked files?
- Conventions: match real codebase patterns?
- Identify: obsolete rules, incorrect rules, valuable rules
- Find gaps: technologies without rules

### 11. Present Refactoring Plan
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

### 12. Refactor Local Rules
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

### 13. Update Metadata
For each refactored local rule:
- Update globs to match tracked file structure
- Test globs with `git ls-files` to verify matches
- Update tags to current technologies
- Ensure metadata accurate for tracked files
- Verify rules trigger appropriately

### 14. Suggest and Create New Rules
For gaps in coverage:
- Suggest `local-*.mdc` for missing technologies
- Follow naming from shared-rules-management
- Ask which to create
- Create basic structure for approved
- User fills details later

### 15. Validate and Save
- Verify metadata syntax
- Test globs against tracked files
- Check naming conventions
- Ensure valuable guidance preserved
- Verify shared rules untouched
- Save all changes

### 16. Generate Report
- Tech stack from tracked files
- Shared rules: count (unchanged)
- Local rules: changes per file
- Migrations: old to new names
- Removals: names and reasons
- Metadata: globs and tags corrected
- New rules: created
- Next steps

## Checklist

- [ ] Git repository verified
- [ ] Shared rules checked (sync if missing)
- [ ] Deprecated .cursorrules handled
- [ ] Nested directories resolved
- [ ] Rules categorized
- [ ] Old rules migrated
- [ ] Tech stack detected from tracked files
- [ ] Codebase practices analyzed from tracked code
- [ ] Existing rules analyzed
- [ ] Rules validated against tracked codebase
- [ ] Plan presented
- [ ] User confirmation received
- [ ] Local rules refactored
- [ ] Metadata updated
- [ ] New rules suggested
- [ ] Results validated
- [ ] Report generated
