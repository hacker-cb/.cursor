# Sync Shared Rules

## Overview
**One-way sync** of shared developer rules FROM `~/.cursor/rules/` TO a target project's `.cursor/rules/` directory. This command ONLY syncs from the shared rules repository to projects, never in reverse. Updates shared rules source before syncing, intelligently migrates existing rules with content analysis and rewriting, and handles file conflicts interactively.

## Steps

### 1. Update Shared Rules Source
- Navigate to `~/.cursor/` directory
- Check git status for uncommitted changes
- If repository is dirty (uncommitted changes):
  - Warn user about uncommitted changes in `~/.cursor/`
  - Ask user: "Continue sync with existing rules? [Y/n]"
  - If user declines: exit sync process
  - If user agrees: skip git pull, continue with existing rules
- If repository is clean:
  - Run `git pull` to get latest shared rules
  - Verify pull successful
- Confirm shared rules are ready for sync

### 2. Validate Target Project
- Verify target project path provided
- Check target directory exists
- Verify target is a git repository (`.git` directory exists)
- Check write permissions to target directory
- Exit with error if validation fails

### 3. Analyze Existing Rules (Deep Analysis)
- Check if `.cursor/rules/` directory exists in target
- If exists: scan for existing rule files (`*.mdc`, `.cursorrules`)
- For each existing rule file found:
  - Read full content
  - Analyze structure and topics covered
  - Identify rule categories (version control, testing, code quality, etc.)
  - Detect tech stack references (languages, frameworks, platforms)
  - Extract project-specific conventions
  - Map content to new shared rules structure
  - Identify what should remain local vs covered by shared rules

### 4. Generate Migration Plan
If existing rules found, create comprehensive migration strategy:

**Analyze and categorize content:**
- Compare existing rules against new shared rules structure
- Identify overlapping content (covered by shared rules)
- Identify project-specific content (needs local rules)
- Detect project architecture pattern:
  - Multi-platform (embedded, cross-platform): platform-centric
  - Multi-module (web services, apps): service-centric
  - Single-module: simple structure
- Suggest appropriate naming pattern based on architecture

**Create migration proposal:**
- List which existing rules map to which shared rules
- Propose new `local-*.mdc` files for project-specific content
- Suggest file structure based on project type:
  - Platform-centric: `local-platform-{name}-{aspect}.mdc`
  - Service-centric: `local-{aspect}-{module}.mdc`
  - Simple: `local-{topic}.mdc`
- Provide complete rewritten content for each local rule:
  - Remove universal content (now in shared rules)
  - Keep only project-specific conventions
  - Restructure to match new format (frontmatter, sections)
  - Add appropriate tags and globs
  - Follow file length guidelines (50-150 lines, max 300)
- Document what gets removed (covered by shared rules)

**Present migration plan to user:**
- Show clear before/after structure
- Display proposed local rule files with full content
- Explain rationale for each decision
- Ask user to review and approve plan

### 5. Execute Migration (After User Approval)
- Remove old rule files from `.cursor/rules/`
- Create new local rule files with rewritten content
- Apply appropriate frontmatter (tags, globs, alwaysApply)
- Verify all files created successfully

### 6. Prepare Target Directory
- Create `.cursor/` directory in target if missing
- Create `.cursor/rules/` directory in target if missing (or clean after migration)
- Verify directories ready for sync

### 7. Sync Shared Rule Files
- List all `shared-*.mdc` files in `~/.cursor/rules/` (source)
- Copy each shared rule file to target project's `.cursor/rules/`
- Track successfully synced files

### 8. Handle Shared Rules Already Present
If any `shared-*.mdc` files exist in target before migration:
- Compare with source versions
- Show differences if any
- **Ask user:** `[O]verwrite with latest`, `[K]eep existing`, or `[D]iff`
- If `Overwrite`: replace with latest from source
- If `Keep`: leave existing version, note in report
- If `Diff`: show full diff, then ask overwrite/keep again

### 9. Generate Migration Report
- Show migration summary:
  - Existing rules analyzed and migrated
  - New local rules created (with file names)
  - Content removed (now covered by shared rules)
- Show sync summary:
  - Shared rules synced (with count)
  - Files skipped (with count)
  - Any errors encountered
- Display final structure of `.cursor/rules/` directory
- Provide next steps and recommendations

## Migration Guidelines

When analyzing and migrating existing rules, follow these principles:

**Content categorization:**
- **Universal principles → Shared rules**: Code quality patterns, SOLID, DRY, testing fundamentals, security basics
- **Project-specific details → Local rules**: Framework APIs, language-specific patterns, project architecture, tool configurations
- **Specific conventions → Local rules**: Naming conventions, directory structure, build commands, deployment procedures

**Detect project architecture:**
- Scan project files and directories to understand structure
- Multi-platform: Look for platform directories (esp32/, stm32/, rpi/, etc.)
- Multi-module: Look for service directories (backend/, frontend/, mobile/, etc.)
- Single-module: Simpler structure, one main codebase
- Choose naming pattern that reflects actual architecture

**Tech stack detection:**
- Identify languages from file extensions and config files
- Identify frameworks from package files and imports
- Identify platforms from build files and toolchains
- Use detected tech stack to create appropriate local rules

**Content rewriting principles:**
- Remove generic advice already covered by shared rules
- Keep only project-specific implementation details
- Add frontmatter with appropriate tags and globs
- Structure with clear sections and bullet points
- Follow file length guidelines (50-150 lines, max 300)
- Make rules actionable and specific to the project

**Globs targeting:**
- Match globs to actual project file structure
- Test globs will work with project organization
- Platform-centric: `["platforms/esp32/**/*"]` or `["esp32/**/*"]`
- Service-centric: `["backend/**/*.py", "api/**/*.py"]`
- Language-specific: `["**/*.ts", "**/*.tsx"]`

**Naming consistency:**
- Match shared rule topics when extending them
- Example: `shared-testing-standards.mdc` → `local-platform-esp32-testing.mdc`
- Example: `shared-code-quality.mdc` → `local-code-quality-backend.mdc`
- Use consistent prefixes based on architecture

**Quality checklist for migration:**
- [ ] All universal content removed from local rules
- [ ] Project-specific content clearly identified
- [ ] Appropriate naming pattern for project architecture
- [ ] Valid frontmatter with tags and globs
- [ ] Globs match actual project structure
- [ ] File length within guidelines
- [ ] Clear sections and actionable points
- [ ] No duplication between local rules

## Checklist
- [ ] Shared rules source (`~/.cursor/rules/`) updated (git pull)
- [ ] Target project validated (git repo, write access)
- [ ] Existing rules analyzed deeply (content, structure, tech stack)
- [ ] Migration plan generated with complete content rewrites
- [ ] Migration plan reviewed and approved by user
- [ ] Old rules removed from `.cursor/rules/`
- [ ] New local rules created with rewritten content
- [ ] Target `.cursor/rules/` directory prepared
- [ ] All `shared-*.mdc` files synced from source to target
- [ ] Conflicts with existing shared rules handled appropriately
- [ ] Migration report generated with before/after summary
- [ ] Final directory structure displayed

