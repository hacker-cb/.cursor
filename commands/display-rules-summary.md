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
   - Count lines with `wc -l`

3. **Display formatted summary**
   - Present clear, readable table with emoji indicators
   - Group by category (Shared/Local)
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

**Statistics:** Total: X rules | Shared: Y | Local: Z | Always: A | Conditional: B | Total Lines: W

## Shared Rules

|   | Rule | File | Lines | Description |
|---|------|------|-------|-------------|
| ✓ | Git Workflow | `shared-version-control.mdc` | 142 | Universal git workflow and branching strategy for project development |
| ✓ | Code Quality Standards | `shared-code-quality.mdc` | 98 | Code quality principles, standards, and best practices |
| 🔀 | TypeScript Standards | `shared-typescript.mdc` | 87 | TypeScript patterns and conventions|

## Local Rules

|   | Rule | File | Lines | Description |
|---|------|------|-------|-------------|
| 🔀 | Backend API Patterns | `local-backend-api.mdc` | 87 | REST API patterns, multi-tenancy, and Traefik integration|
| 🔀 | Frontend Standards | `local-frontend-vuejs.mdc` | 65 | Vue.js conventions and testing with Vitest|
| ✓ | Architecture | `local-architecture.mdc` | 124 | Project architecture, module structure, and design patterns |
```

**Icon Legend:**
- ✓ = Always applied to all files
- 🔀 = Conditionally applied based on globs/tags

### Key Information to Display

**Statistics:**
- Total rule count
- Shared vs local breakdown
- Always applied vs conditional breakdown
- Total line count (or token count if possible)

**Table structure:**
- Emoji column: ✓ (always) or 🔀 (conditional)
- Rule title
- File name
- Line count (or token count if possible)
- Description with conditions for conditional rules

**Apply mode detection:**
- `alwaysApply: true` → ✓ (always applied)
- `alwaysApply: false` → 🔀 (conditional with globs/tags)
- For conditional rules: append "<br>**Applies to:**<br>" [globs]("<br>"-separated) to description

## Checklist

- [ ] Scan and parse all `.mdc` files in `.cursor/rules/`
- [ ] Extract metadata (title, description, apply mode, globs/tags, line/token count)
- [ ] Determine emoji indicator (✓ or 🔀) based on `alwaysApply` flag
- [ ] Append conditions inline with em dash (—) for conditional rules
- [ ] Group rules by category (shared/local)
- [ ] Display formatted summary with statistics and icon legend
- [ ] Show only final output (hide implementation details)

