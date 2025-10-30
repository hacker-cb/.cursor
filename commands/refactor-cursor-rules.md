# Refactor Cursor Rules

## Overview
Analyze the project's tech stack and refactor `.cursor/rules/*.mdc` files to match the real project by removing duplicates, irrelevant rules, and unnecessary examples. Update rule metadata to ensure precise application conditions.

## Steps

1. **Detect project tech stack**
   - Scan for dependency files: `package.json`, `requirements.txt`, `go.mod`, `Cargo.toml`, `pom.xml`, `Gemfile`, etc.
   - Identify languages from file extensions in the project
   - Detect frameworks and major libraries from dependencies
   - List build tools and development tools in use
   - Create summary of detected tech stack

2. **Find all cursor rules**
   - Recursively search for `.mdc` files in `.cursor/rules/` at any nesting level
   - Use: `find .cursor/rules -name "*.mdc" -type f` or glob pattern `**/*.mdc`
   - List all found rule files with their paths
   - Provide count of total rules found

3. **Analyze cursor rules**
   - Read all found `.mdc` files
   - Parse YAML frontmatter (metadata section)
   - Extract rule content and identify purpose
   - Categorize rules by type:
     - Language-specific (Python, JavaScript, Go, etc.)
     - Framework-specific (React, Django, Express, etc.)
     - General best practices
     - Project-specific custom rules
   - Identify duplicate or overlapping rules

4. **Request user confirmation**
   - Present summary of findings:
     - Current tech stack detected
     - Total number of rules found
     - Rules that will be removed (irrelevant to project)
     - Rules that will be consolidated (duplicates)
     - Rules that will be updated (metadata changes)
     - Rules that will be preserved as-is
   - Provide clear breakdown of planned changes
   - Ask for explicit confirmation to proceed with refactoring
   - If user declines, stop execution

5. **Refactor rules**
   - Remove rules for technologies NOT used in the project
   - Consolidate duplicate or overlapping rules into single comprehensive rules
   - Trim verbose examples while keeping essential guidance
   - Remove unnecessary code snippets that don't add value
   - Simplify overly complex rules
   - Preserve critical project-specific rules
   - Ensure each rule has a clear, focused purpose
   - Keep rule content concise and actionable

6. **Update rule metadata**
   - Refine YAML frontmatter "when to apply" conditions
   - Update file glob patterns to match actual project structure
   - Set appropriate language tags based on project languages
   - Add or update path patterns for precise rule application
   - Reference: https://cursor.com/docs/context/rules#rule-anatomy
   - Ensure metadata accurately reflects when each rule should trigger

7. **Validate and save**
   - Review refactored rules for completeness
   - Ensure no critical guidance was lost
   - Verify metadata syntax is correct
   - Save updated `.mdc` files
   - Provide summary of changes made

## Refactoring Checklist

- [ ] Tech stack detected and documented
- [ ] All `.mdc` files found recursively
- [ ] Rules categorized by type
- [ ] Summary of changes presented to user
- [ ] User confirmation received
- [ ] Irrelevant rules removed
- [ ] Duplicate rules consolidated
- [ ] Examples trimmed to essentials
- [ ] Metadata updated with accurate conditions
- [ ] File globs match project structure
- [ ] Changes validated and saved

## Example Metadata Update

Before:
```yaml
---
tags: ["javascript", "typescript"]
globs: ["**/*.js", "**/*.ts"]
---
```

After (for a Python-only project):
```yaml
---
tags: ["python"]
globs: ["**/*.py", "src/**/*.py", "tests/**/*.py"]
---
```

