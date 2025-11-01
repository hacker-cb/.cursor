# Display Rules Summary

## Overview
Scan and display all Cursor rules with their apply modes, descriptions, and metadata. Helps understand which rules are active and their configuration.

## Steps

1. **Scan rules directory**
   - Check `.cursor/rules/` in project root
   - Parse all `.mdc` files for metadata

2. **Extract rule information**
   - Use `head -n 10-15` to read first lines of each file
   - Parse YAML frontmatter for `alwaysApply: true/false`
   - Extract title from first `#` heading
   - Extract description from first paragraph after title
   - Extract globs/tags from frontmatter for conditional rules
   - Count lines with `wc -l` (or tokens if possible)

3. **Display formatted summary**
   - Present clear, readable table with emoji indicators
   - Group by category (Shared/Local)
   - For local rules: detect subcategories from filename patterns
     - Backend rules: `local-backend-*.mdc` or `*-backend-*.mdc`
     - Frontend rules: `local-frontend-*.mdc` or `*-frontend-*.mdc`
     - CLI rules: `local-cli-*.mdc` or `*-cli-*.mdc`
     - Infrastructure rules: `local-infra-*.mdc` or `*-infrastructure-*.mdc`
     - Module-specific: `local-{module}-*.mdc` patterns
     - Cross-cutting: other `local-*.mdc` files
   - Show statistics (total, shared/local split, always/conditional split)
   - Include descriptions with conditions for conditional rules

4. **Implementation notes**
   - Hide technical details and temporary scripts from user
   - Only show the final formatted output
   - Handle missing metadata gracefully
   - Keep output concise and scannable

## Display Format

### Markdown Summary with Tables

```markdown
# Cursor Rules Summary

**Statistics:** Total: X rules | Shared: Y | Local: Z (Backend: N, Frontend: M, CLI: P, Infrastructure: Q, Other: R) | Always: A | Conditional: B | Total Lines: W

## Shared Rules

|   | Rule | File | Lines | Description |
|---|------|------|-------|-------------|
| ✓ | Git Workflow | `shared-version-control.mdc` | 142 | Universal git workflow and branching strategy for project development |
| ✓ | Code Quality Standards | `shared-code-quality.mdc` | 98 | Code quality principles, standards, and best practices |
| 🔀 | TypeScript Standards | `shared-typescript.mdc` | 87 | TypeScript patterns and conventions|

## Local Rules

### Backend (3 rules)

|   | Rule | File | Lines | Description |
|---|------|------|-------|-------------|
| 🔀 | Backend API Patterns | `local-backend-api.mdc` | 87 | REST API patterns, multi-tenancy, and Traefik integration|
| 🔀 | Backend Multi-Tenancy | `local-backend-multi-tenancy.mdc` | 124 | Multi-tenancy architecture and ownership patterns|
| 🔀 | Backend Testing | `local-backend-testing.mdc` | 92 | Backend testing patterns, fixtures, and requirements (pytest)|

### Frontend (2 rules)

|   | Rule | File | Lines | Description |
|---|------|------|-------|-------------|
| 🔀 | Frontend Vue.js | `local-frontend-vue.mdc` | 65 | Vue.js conventions and testing with Vitest|
| 🔀 | Frontend Testing | `local-frontend-testing.mdc` | 78 | Frontend testing patterns with Vitest and Playwright|

### CLI (2 rules)

|   | Rule | File | Lines | Description |
|---|------|------|-------|-------------|
| 🔀 | CLI Python | `local-cli-python.mdc` | 105 | Python CLI architecture with Typer and Rich|
| 🔀 | CLI Bash | `local-cli-bash.mdc` | 68 | Bash CLI patterns and hostname functions|

### Infrastructure (2 rules)

|   | Rule | File | Lines | Description |
|---|------|------|-------|-------------|
| 🔀 | Infrastructure Docker | `local-infra-docker.mdc` | 89 | Docker containers management and commands|
| ✓ | Infrastructure Deployment | `local-infra-deployment.mdc` | 72 | Deployment and SSH access patterns (Linux only)|

### Cross-Cutting (1 rule)

|   | Rule | File | Lines | Description |
|---|------|------|-------|-------------|
| ✓ | Architecture | `local-architecture.mdc` | 124 | Project architecture, module structure, and design patterns |
```

**Icon Legend:**
- ✓ = Always applied to all files
- 🔀 = Conditionally applied based on globs/tags

### Key Information to Display

**Statistics:**
- Total rule count
- Shared vs local breakdown
- Local rules subcategory breakdown (backend, frontend, cli, infrastructure, other)
- Always applied vs conditional breakdown
- Total line count (or token count if possible)

**Table structure:**
- Group shared rules in one section
- Group local rules by subcategory (backend, frontend, cli, infrastructure, cross-cutting)
- Each subcategory shows count in heading
- Emoji column: ✓ (always) or 🔀 (conditional)
- Rule title
- File name
- Line count (or token count if possible)
- Description with conditions for conditional rules

**Apply mode detection:**
- `alwaysApply: true` → ✓ (always applied)
- `alwaysApply: false` → 🔀 (conditional with globs/tags)
- For conditional rules: append " — **Applies to:** [globs]" (comma-separated) to description

## Checklist

- [ ] Scan and parse all `.mdc` files in `.cursor/rules/`
- [ ] Extract metadata (title, description, apply mode, globs/tags, line/token count)
- [ ] Determine emoji indicator (✓ or 🔀) based on `alwaysApply` flag
- [ ] Append conditions inline with em dash (—) for conditional rules
- [ ] Group shared rules in one section
- [ ] Group local rules into subcategories (backend, frontend, cli, infrastructure, cross-cutting)
- [ ] Display formatted summary with statistics breakdown and icon legend
- [ ] Show only final output (hide implementation details)

