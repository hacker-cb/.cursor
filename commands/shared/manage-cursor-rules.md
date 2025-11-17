# Manage Cursor Rules

## Overview
Analyze project and manage cursor rules in `.cursor/rules/`. For new projects: generates rules from scratch based on detected patterns. For existing projects: validates and refactors rules against current codebase, quickly cleans up outdated content, or performs comprehensive documentation audit (cursor rules + all project .md files). Handles initialization, maintenance, cleanup, and complete documentation organization.

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

### 3. Determine Workflow Based on Priority

**Priority 1: If old rules exist (with or without local rules):**
- Show status:
  - Old rules requiring migration: X files
  - Local rules: Y files (if any)
- Explain: Old rules must be migrated to proper naming convention first
- Auto-select: **OLD RULES flow** (deep analysis and migration)
- Note: After migration complete, user can run command again for local rules management

**Priority 2: If no old rules, but has local rules:**
- Show status: Local rules found: X files
- Ask user: "What would you like to do? [refactor/cleanup/docs-check/init]"
  - **refactor** - Full validation and update with gap filling
  - **cleanup** - Quick removal of outdated content only
  - **docs-check** - Audit and organize all documentation (rules + scattered .md files)
  - **init** - Start fresh (regenerate all rules from scratch)
- Proceed with chosen workflow

**Priority 3: If no rules at all:**
- Show status: No local or old rules found
- Ask user: "Generate rules from scratch? [Y/n]"
- If Yes: **INIT flow**
- If No: exit with message about running sync-shared-rules first

### 4. Check Shared Rules Present
- List all `shared-*.mdc` files in `.cursor/rules/`
- If no shared rules found:
  - Explain shared rules are required foundation
  - Ask: "Run sync-shared-rules now? [Y/n]"
  - If Yes: run sync, wait for completion
  - If No: exit (shared rules required)
- If shared rules present: proceed

### 5. Check for Deprecated .cursorrules File
- Search for `.cursorrules` (deprecated format)
- If found: ask to delete, migrate to `.cursor/rules/*.mdc`

### 6. Check for Nested .cursor/rules Directories
- Search for `.cursor/rules/` in subdirectories
- If found: ask to merge/delete/skip
- Ensure single rules directory at root

---

## Common Functions

These functions are used by INIT, REFACTOR, and CLEANUP flows as needed.

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

### Check Documentation Separation
Validate cursor rules contain agent guidance, not human documentation:

**Detect documentation content in rules:**
- API endpoint details, request/response schemas, HTTP methods
- Deployment procedures, infrastructure setup, server configurations
- Installation steps, environment setup for users
- Troubleshooting guides, FAQ sections, error resolution
- User-facing feature descriptions and tutorials
- Operational runbooks, monitoring dashboards
- Architecture diagrams and extensive system overviews

**Flag for removal or relocation:**
- Mark sections that belong in README.md or `/docs`
- Suggest moving API specs to documentation
- Suggest moving deployment guides to `/docs/deployment.md`
- Suggest moving architecture diagrams to `/docs/architecture.md`
- Suggest replacing detailed content with references: "See README.md for API details"

**Keep in cursor rules:**
- Code patterns agent should follow
- Naming conventions for code generation
- Architecture boundaries agent must respect
- Testing patterns agent should implement
- Error handling patterns for code
- Build commands agent needs to use

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
- Verify tags match rule content (tags should reflect languages/frameworks/concerns covered in the rule)
- Verify globs are appropriately specific (not too broad like `**/*`, not too narrow)
- Verify tags and globs alignment (tags should match file types in globs, e.g., Python tag with `*.py` globs)
- Verify frontmatter completeness (check if tags and globs are present when needed for file targeting)
- Test globs match tracked files with `git ls-files`
- Check naming follows agreed convention
- Verify tags accurate for file targeting
- Check for broken links (validate internal anchor links and cross-references to other rule files exist)
- Ensure 50-150 lines per rule (max 300 if needed)
- Call: [Check Documentation Separation](#check-documentation-separation)
- Save all rule files

### Generate Report
- Tech stack summary
- Shared rules status
- Local rules created/updated (list with descriptions)
- Patterns documented
- Issues found and resolved
- Documentation content flagged (API specs, deployment, troubleshooting moved to docs)
- Next steps and recommendations

**Note:** To display rules information at any time, you can run `display-rules-summary` command.

---

## INIT Flow (No Local Rules)

Generate rules from scratch based on project analysis.

### 7. Detect and Analyze Project
- Call: [Detect Tech Stack](#detect-tech-stack)
- Call: [Analyze Code Patterns](#analyze-code-patterns)
- Document findings for rule generation

### 8. Confirm with User
- Call: [Confirm Structure and Naming Policy](#confirm-structure-and-naming-policy)
- Get user approval before generation

### 9. Present Generation Plan
- Tech stack detected (languages, frameworks, tools)
- Architecture identified (modules, platforms, structure)
- Local rules to generate with proposed names
- Patterns to document (naming, testing, style)
- Ask confirmation to proceed

### 10. Generate Local Rules
Create `local-*.mdc` files following confirmed naming:
- Per language/framework rules (e.g., `local-python.mdc`, `local-typescript.mdc`)
- Per module/platform rules if multi-module (e.g., `local-backend.mdc`, `local-frontend.mdc`)
- Architecture and structure rules (e.g., `local-architecture.mdc`)
- Testing conventions (e.g., `local-testing.mdc`)
- Code style and formatting (e.g., `local-style.mdc`)
- Use YAML frontmatter with appropriate tags and globs
- Base rules on actual code patterns found

### 11. Validate and Report
- Call: [Validate Generated Rules](#validate-generated-rules)
- Call: [Generate Report](#generate-report)
- Recommend reviewing and refining generated rules

---

## REFACTOR Flow (Has Local Rules)

Validate and update existing rules against current codebase.

### 7. Refresh Context and Handle Mixed Rules
- Re-read all existing local rules
- Load into agent context for fresh understanding
- If old rules (without prefix) also exist:
  - Note their presence for deeper analysis
  - Will analyze alongside local rules in step 10
  - Will suggest migration in step 11

### 8. Detect Current State
- Call: [Detect Tech Stack](#detect-tech-stack)
- Call: [Analyze Code Patterns](#analyze-code-patterns)
- Document current project state

### 9. Confirm with User
- Call: [Confirm Structure and Naming Policy](#confirm-structure-and-naming-policy)
- Verify understanding matches reality

### 10. Compare Rules to Reality (Iterative)

Ask user: "How many analysis iterations? [default: 5]"

Perform iterative deep analysis (recommended: 5 passes):
- **Pass 1**: Read and understand all local rules content
- **Pass 2**: Compare tech stack documented vs current reality
- **Pass 3**: Validate globs and patterns against actual code
- **Pass 4**: Check for obsolete guidance and gaps
- **Pass 5**: Cross-rule validation and consolidation opportunities

For each iteration:
- Analyze existing local rules content
- If old rules exist: analyze their content too
- Identify valuable practices worth keeping
- Compare rules to actual code patterns
- Check tech stack still matches documented
- Verify globs still match project structure
- Find obsolete or outdated guidance
- Identify coverage gaps (missing rules)
- For old rules: determine migration strategy

### 11. Present Refactoring Plan
- Tech stack changes vs documented
- Rules to update with specific changes
- Rules to remove or consolidate
- Metadata corrections needed (globs, tags)
- New rules to create for gaps
- If old rules exist: migration plan (rename, refactor, split)
- Ask user confirmation to proceed

### 12. Refactor Local Rules
- Preserve valuable guidance that's still relevant
- Update rules to match current code reality
- Remove obsolete sections and outdated practices
- Fix metadata (globs, tags) for accuracy
- Create new rules for identified gaps
- If old rules exist: migrate to proper `local-*` naming and delete old files
- Target 50-150 lines per rule (max 300 if comprehensive)

### 13. Validate, Report, and Recommend
- Call: [Validate Generated Rules](#validate-generated-rules)
- Call: [Generate Report](#generate-report)
- Recommend starting new agent session to load updated rules

---

## OLD RULES Flow (Has Old Rules Without Prefix)

Deep analysis and refactoring of rules without proper naming prefix.

### 7. Analyze Old Rules Content
- Read all old rule files (without `local-` or `shared-` prefix)
- Categorize content by domain:
  - Language/framework-specific guidance
  - Architecture and structure patterns
  - Testing conventions
  - Code style and formatting
  - Project-specific vs universal guidance
- Identify valuable vs outdated content
- Check for mixed content that should be split

### 8. Detect Current Project State
- Call: [Detect Tech Stack](#detect-tech-stack)
- Call: [Analyze Code Patterns](#analyze-code-patterns)
- Document current codebase reality

### 9. Compare Old Rules to Current Reality (Iterative)

Ask user: "How many analysis iterations? [default: 5]"

Perform iterative deep analysis (recommended: 5 passes):
- **Pass 1**: Categorize content and identify domains
- **Pass 2**: Match content to current tech stack and code patterns
- **Pass 3**: Separate valuable vs outdated guidance
- **Pass 4**: Check globs/tags accuracy and identify universal content
- **Pass 5**: Determine migration strategy and file structure

For each iteration:
- Match old rules content to current code patterns
- Identify still-relevant guidance worth preserving
- Find outdated practices no longer used
- Detect mismatches with current tech stack
- Check if globs/tags still accurate
- Find content better suited for shared rules

### 10. Confirm with User
- Call: [Confirm Structure and Naming Policy](#confirm-structure-and-naming-policy)
- Present findings from old rules analysis
- Show what's still relevant vs outdated

### 11. Present Migration and Refactoring Plan
- Old rules content breakdown
- Guidance worth preserving with rationale
- Outdated content to remove with explanation
- Suggested new file structure with proper naming
- Content to split into multiple files
- Content to consolidate
- Potential shared rules candidates
- Ask user confirmation to proceed

### 12. Refactor and Migrate
- Create new `local-*.mdc` files with proper naming
- Preserve valuable guidance from old rules
- Update content to match current codebase
- Remove outdated and irrelevant sections
- Split mixed content into focused files
- Add proper YAML frontmatter (tags, globs)
- Ensure 50-150 lines per rule (max 300)
- Delete old rule files after successful migration

### 13. Validate, Report, and Recommend
- Call: [Validate Generated Rules](#validate-generated-rules)
- Call: [Generate Report](#generate-report)
- Show migration summary (old → new mapping)
- Recommend starting new agent session to load updated rules

---

## CLEANUP Flow (Quick Outdated Content Removal)

Lightweight analysis focused solely on detecting and removing outdated content. No rule generation or gap filling.

### 7. Refresh Context
- Re-read all existing local rules
- Load into agent context for fresh understanding

### 8. Detect Current State
- Call: [Detect Tech Stack](#detect-tech-stack)
- Skip comprehensive code pattern analysis (CLEANUP uses lightweight validation in step 9)
- Create snapshot of current technologies and structure

### 9. Analyze Each Rule for Outdated Content (Iterative)

Ask user: "How many analysis iterations? [default: 5]"

Perform iterative lightweight analysis (recommended: 5 passes):
- **Pass 1**: Technology check - extract and validate frameworks/libraries
- **Pass 2**: Glob validation - test patterns against tracked files
- **Pass 3**: Pattern check - compare to actual code samples
- **Pass 4**: Dependency check - verify against manifests
- **Pass 5**: Cross-validation and final categorization

For each `local-*.mdc` file, across all iterations:

**Technology Check:**
- Extract all technologies/frameworks mentioned in rule
- Cross-reference with current project tech stack
- Flag rules where ALL mentioned tech removed from project
- Flag sections referencing removed frameworks/libraries

**Glob Validation:**
- Parse glob patterns from YAML frontmatter
- Test each glob against `git ls-files` output
- Flag globs matching zero tracked files
- Flag globs matching wrong file types

**Pattern Check:**
- Extract code patterns/conventions from rule content
- Sample 10-15 current files the rule claims to cover
- Compare described patterns vs actual code
- Flag patterns contradicting current implementation
- Flag patterns not found in any current code

**Dependency Check:**
- Find dependency/library references in rule content
- Check if dependencies still in project manifests
- Flag references to removed dependencies
- Flag version-specific advice for outdated versions

**Documentation Separation Check:**
- Call: [Check Documentation Separation](#check-documentation-separation)
- Flag API endpoint details, schemas, deployment procedures
- Flag installation guides, troubleshooting sections
- Flag user-facing content that belongs in README or `/docs`
- Suggest moving to appropriate documentation files

### 10. Categorize Outdated Items

**Files to Delete (entire file outdated):**
- All referenced technologies removed from project
- All glob patterns match zero tracked files
- Framework-specific rules for removed frameworks
- Content fully duplicates shared rules

**Sections to Remove (parts of file outdated):**
- References to deprecated APIs not in current code
- Describes patterns contradicting actual code
- Mentions libraries no longer in dependencies
- Version-specific advice for old versions
- Duplicates specific shared rule sections
- Documentation content (API specs, deployment, troubleshooting, installation guides)

**Files to Keep (still relevant):**
- Core technologies still in use
- Glob patterns match current files
- Patterns align with current code

### 11. Present Cleanup Plan
- Show files marked for deletion with rationale
- Show sections marked for removal with line ranges and reasons
- Display what's being preserved
- Ask: "Remove outdated content? [Y/n]"
- Get user confirmation before any changes

### 12. Remove Outdated Content
- Delete outdated rule files (or provide deletion commands if in ask mode)
- Remove outdated sections from files (or provide line ranges and instructions if in ask mode)
- Keep all valid content unchanged
- Do not create new rules or fill gaps

### 13. Generate Cleanup Report
- Files deleted (list with reasons)
- Sections removed (count and details)
- Documentation content moved to docs (API specs, deployment, troubleshooting)
- Files preserved (list)
- What was kept and why
- Recommend starting new agent session to reload rules

---

## DOCS-SEPARATION Flow (Complete Documentation Audit)

Comprehensive audit and organization of all project documentation:
- Scans cursor rules for documentation content that belongs in `/docs`
- Finds all scattered markdown files throughout project
- Consolidates, organizes, and cleans up documentation structure

### 7. Refresh Context
- Re-read all existing local rules
- Load into agent context for fresh understanding
- Skip shared rules (focus on local rules only)

### 8. Scan Project for All Documentation Files

**Find all markdown files using `git ls-files`:**
- List all tracked `.md` files in project
- Exclude legitimate locations:
  - `README.md` (root)
  - `CHANGELOG.md`, `CONTRIBUTING.md`, `LICENSE.md` (root)
  - `/docs/**/*.md` (documentation directory)
  - `/node_modules/**`, `/vendor/**` (dependencies)
- Flag scattered documentation files in other locations

**Categorize scattered .md files:**

**Legitimate scattered locations (keep):**
- Package-level READMEs in multi-package projects (`packages/*/README.md`)
- Module documentation in appropriate subdirectories (`backend/README.md`, `frontend/README.md`)
- Language/tool-specific files (`.github/ISSUE_TEMPLATE.md`, `.github/PULL_REQUEST_TEMPLATE.md`)

**Should consolidate to /docs:**
- API documentation files outside `/docs` (`api.md`, `endpoints.md` in root or subdirs)
- Architecture files (`architecture.md`, `design.md` in random locations)
- Deployment guides (`deployment.md`, `setup.md` scattered)
- User guides and tutorials outside `/docs`
- Development guides outside proper location
- Troubleshooting files scattered around

**May be obsolete (ask user):**
- Files with outdated names (`OLD_README.md`, `README.old.md`)
- Duplicate documentation (multiple files covering same topic)
- Empty or nearly empty markdown files
- Files not referenced anywhere

### 9. Analyze Each Rule for Documentation Content

Scan each `local-*.mdc` file for human-oriented documentation:

**API Documentation:**
- Endpoint URLs, paths, routes
- HTTP methods (GET, POST, PUT, DELETE)
- Request/response schemas and formats
- Query parameters, headers, body structures
- Status codes and error responses
- Authentication/authorization flows details
- Rate limiting specifications
- API versioning information

**Deployment and Infrastructure:**
- Server setup instructions
- Cloud provider configurations
- Container orchestration details
- Environment variable lists with descriptions
- Port mappings and network configurations
- SSL/TLS certificate setup
- Load balancer configurations
- Database connection strings

**Installation and Setup:**
- Step-by-step installation guides
- Dependency installation commands
- Environment setup for end users
- Configuration file templates
- First-time setup wizards
- System requirements lists

**Troubleshooting and Operations:**
- Common error messages and solutions
- FAQ sections
- Debug procedures
- Log analysis guides
- Performance tuning guides
- Monitoring dashboard setup
- Backup and recovery procedures

**User-Facing Content:**
- Feature descriptions for end users
- Usage tutorials and walkthroughs
- Screenshots or UI descriptions
- User guides and manuals
- Release notes details

**Architecture Documentation:**
- System architecture diagrams (extensive)
- Infrastructure overviews for humans
- Service interaction diagrams
- Data flow diagrams
- Deployment architecture

### 9. Categorize All Findings

**Documentation content from cursor rules to move:**
- API specifications → README.md or `/docs/api.md`
- Deployment procedures → `/docs/deployment.md`
- Installation guides → README.md (Quick Start section)
- Troubleshooting → `/docs/troubleshooting.md`
- Architecture diagrams → `/docs/architecture.md`
- User features → README.md or `/docs/user-guide.md`
- Operational runbooks → `/docs/operations.md`

**Scattered markdown files to consolidate:**
- Move scattered API docs to `/docs/api.md`
- Move scattered architecture docs to `/docs/architecture.md`
- Move scattered deployment guides to `/docs/deployment.md`
- Move scattered user guides to `/docs/`
- Consolidate duplicate documentation into single files
- Consider package/module READMEs (keep if legitimate structure)

**Files to review for deletion:**
- Obsolete markdown files with old naming
- Empty or nearly empty documentation files
- Duplicate content that can be merged
- Unreferenced documentation

**Agent guidance to keep in rules:**
- Code patterns and conventions
- Naming standards for generated code
- Architecture boundaries agent must respect
- Testing patterns to implement
- Error handling patterns in code
- Logging patterns for generated code
- Build/test commands agent needs

**Borderline content (review with user):**
- High-level architecture descriptions (brief overview in rules OK, detailed diagrams to docs)
- Configuration patterns (patterns in rules, specific configs to docs)
- Module boundaries (logical boundaries in rules, deployment details to docs)

### 10. Present Audit Report

**Show findings from cursor rules:**
- Rule file name
- Documentation sections found (with line ranges)
- Suggested destination (README, docs/api.md, etc.)
- Rationale for each suggestion
- Content preview (first few lines)

**Show scattered markdown files found:**
- File path and size
- Category (API, architecture, deployment, etc.)
- Current location vs suggested location
- Whether it duplicates existing documentation
- Recommendation (move, consolidate, delete, keep)

**Show potential issues:**
- Empty or nearly empty .md files
- Files with obsolete naming patterns
- Duplicate documentation covering same topics
- Unreferenced files

**Summary statistics:**
- Documentation sections in cursor rules
- Scattered markdown files found
- Files to consolidate to /docs
- Files to review for deletion
- Breakdown by category (API, deployment, troubleshooting, etc.)

**Ask user what to do:**
- "Proceed with documentation organization? [Y/n]"
- "Show detailed extraction and consolidation plan first? [Y/n]"

### 11. Organize Documentation (If Approved)

If user approves moving content:

**Create/update documentation files:**
- Create `/docs` directory if needed
- Extract documentation sections from cursor rules
- Move scattered markdown files to appropriate locations
- Consolidate duplicate documentation
- Create organized documentation files (api.md, deployment.md, architecture.md, etc.)
- Format content for human readers
- Add table of contents if needed
- Add cross-references between docs

**Handle scattered markdown files:**
- Move legitimate docs to `/docs` with proper naming
- Consolidate duplicates (merge content, keep best version)
- Delete obsolete/empty files (with user confirmation)
- Keep package/module READMEs if appropriate
- Update internal links in moved files
- Preserve git history when moving files

**Update cursor rules:**
- Remove documentation sections
- Replace with brief references: "See docs/api.md for endpoint details"
- Keep essential agent guidance
- Maintain rule structure and formatting

**Update README.md:**
- Add links to new/moved documentation files
- Add brief overview sections if needed
- Ensure Quick Start section references docs
- Remove duplicate content now in /docs
- Keep README focused and scannable

### 12. Generate Separation Report

**Content extracted from cursor rules:**
- Sections extracted from each rule file (with line ranges)
- Documentation categories moved
- References added to rules pointing to docs

**Scattered markdown files organized:**
- Files moved to `/docs` (list with old → new paths)
- Files consolidated (list merges performed)
- Files deleted (list with rationale)
- Package/module READMEs kept (list)
- Broken internal links fixed

**Documentation structure created:**
- New documentation files created in `/docs` (list with descriptions)
- Existing documentation files updated
- README.md updates made
- Cross-references added between docs
- Table of contents added where appropriate

**Cursor rules updated:**
- Files modified (list)
- Documentation sections removed (count and line ranges)
- References added to docs
- Agent guidance preserved and focused

**Summary statistics:**
- Total files moved/consolidated
- Line counts: cursor rules before/after
- Documentation files: before/after organization
- Deleted files count

**Recommendations:**
- Review documentation for accuracy
- Test all internal documentation links
- Update documentation as code evolves
- Keep rules focused on agent guidance
- Consider .gitignore for future scattered docs
- Start new agent session to reload rules

---

## Checklist

### Common (All Flows)

Note: Items marked "skip for CLEANUP" are not required for the CLEANUP flow.

- [ ] Git repository verified
- [ ] Existing rules categorized
- [ ] Shared rules present/synced
- [ ] Deprecated files handled
- [ ] Nested directories resolved
- [ ] Tech stack detected
- [ ] Code patterns analyzed (skip for CLEANUP)
- [ ] Structure and naming confirmed (skip for CLEANUP)

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

### CLEANUP Flow
- [ ] Local rules context refreshed
- [ ] Current tech stack detected
- [ ] Each rule analyzed for outdated content
- [ ] Technologies cross-referenced with project
- [ ] Glob patterns validated against tracked files
- [ ] Code patterns compared to actual implementation
- [ ] Dependencies verified in manifests
- [ ] Documentation separation checked (API specs, deployment, troubleshooting)
- [ ] Outdated items categorized (delete/remove/keep)
- [ ] Cleanup plan presented
- [ ] User confirmation obtained
- [ ] Outdated content removed
- [ ] Cleanup report provided
- [ ] New session recommended

### DOCS-SEPARATION Flow
- [ ] Local rules context refreshed
- [ ] All project markdown files scanned with git ls-files
- [ ] Scattered .md files identified and categorized
- [ ] Legitimate scattered locations identified (packages/modules)
- [ ] Files to consolidate to /docs flagged
- [ ] Obsolete/duplicate files marked for review
- [ ] Each rule scanned for documentation content
- [ ] API documentation sections identified
- [ ] Deployment/infrastructure content found
- [ ] Installation guides detected
- [ ] Troubleshooting sections located
- [ ] User-facing content flagged
- [ ] Architecture documentation marked
- [ ] All findings categorized by destination
- [ ] Audit report presented (rules + scattered files)
- [ ] User approval obtained
- [ ] /docs directory created if needed
- [ ] Documentation files created/updated
- [ ] Content extracted from rules
- [ ] Scattered markdown files moved to /docs
- [ ] Duplicate documentation consolidated
- [ ] Obsolete files deleted (with confirmation)
- [ ] Internal links updated in moved files
- [ ] Rules updated with doc references
- [ ] README.md updated with links
- [ ] Separation report provided
- [ ] New session recommended
