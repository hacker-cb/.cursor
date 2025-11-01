# Display Rules Summary

## Overview
Scan and display all Cursor rules with their apply modes, descriptions, and metadata. Helps understand which rules are active and their configuration.

## Steps

**Note:** To sync shared rules from workspace, use `sync-shared-rules`. To setup or refactor project rules, use `manage-cursor-rules`.

1. **Scan rules directory**
   - Check `.cursor/rules/` in project root
   - Parse all `.mdc` files for metadata

2. **Extract rule information**
   - Use `head -n 10-15` to read first lines of each file
   - Parse YAML frontmatter for `alwaysApply: true/false`
   - Extract title from first `#` heading
   - Extract description from first paragraph after title
   - Extract globs/tags from frontmatter for conditional rules
   - For local rules: detect project area from filename (e.g., `local-backend-api.mdc` → Backend)
   - Count lines with `wc -l`

3. **Display formatted summary**
   - Present clear, readable table with emoji indicators
   - Group shared rules in one section
   - Split local rules by project area (Backend, Frontend, CLI, Infrastructure, Documentation, etc.)
   - Show statistics (total, shared/local split, always/conditional split, line count)
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
| 🔀 | TypeScript Standards | `shared-typescript.mdc` | 87 | TypeScript patterns and conventions — **Applies to:** `**/*.ts`, `**/*.tsx` |

## Local Rules

### Backend

|   | Rule | File | Lines | Description |
|---|------|------|-------|-------------|
| 🔀 | Backend API Patterns | `local-backend-api.mdc` | 87 | REST API patterns, multi-tenancy, and Traefik integration — **Applies to:** `backend/app/api/**/*.py` |
| 🔀 | Backend Testing | `local-backend-testing.mdc` | 124 | Backend testing patterns and fixtures (pytest) — **Applies to:** `backend/tests/**/*.py` |

### Frontend

|   | Rule | File | Lines | Description |
|---|------|------|-------|-------------|
| 🔀 | Frontend Vue.js | `local-frontend-vue.mdc` | 65 | Vue.js patterns and conventions — **Applies to:** `frontend/**/*.vue`, `frontend/**/*.ts` |
| 🔀 | Frontend Testing | `local-frontend-testing.mdc` | 89 | Frontend testing (Vitest + Playwright) — **Applies to:** `frontend/tests/**/*` |

### CLI

|   | Rule | File | Lines | Description |
|---|------|------|-------|-------------|
| 🔀 | CLI Python | `local-cli-python.mdc` | 142 | Python CLI architecture with Typer — **Applies to:** `scripts/cli/**/*.py` |

### Cross-Cutting

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
- Always applied vs conditional breakdown
- Total line count

**Table structure:**
- Emoji column: ✓ (always) or 🔀 (conditional)
- Rule title
- File name
- Line count
- Description with conditions for conditional rules

**Apply mode detection:**
- `alwaysApply: true` → ✓ (always applied)
- `alwaysApply: false` → 🔀 (conditional with globs/tags)
- For conditional rules: append " — **Applies to:** [comma-separated globs]" to description

**Local rules grouping:**
- Detect project area from filename pattern: `local-{area}-*.mdc` or `local-{area}.mdc`
- Common areas: Backend, Frontend, CLI, Infrastructure, Documentation, Testing
- Group rules under subsections: `### Backend`, `### Frontend`, etc.
- Cross-cutting rules (no area prefix or `local-architecture.mdc`): group under `### Cross-Cutting`
- Sort areas alphabetically, with Cross-Cutting last

## Checklist

- [ ] Scan and parse all `.mdc` files in `.cursor/rules/`
- [ ] Extract metadata (title, description, apply mode, globs/tags, line count)
- [ ] Determine emoji indicator (✓ or 🔀) based on `alwaysApply` flag
- [ ] Append conditions with em dash (—) for conditional rules
- [ ] Group shared rules in one section
- [ ] Detect project areas from local rule filenames
- [ ] Group local rules by area (Backend, Frontend, CLI, Infrastructure, etc.)
- [ ] Sort local rule subsections alphabetically (Cross-Cutting last)
- [ ] Display formatted summary with statistics and icon legend
- [ ] Show only final output (hide implementation details)

