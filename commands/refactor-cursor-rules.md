# Refactor Cursor Rules

## Overview
Analyze project tech stack and refactor `.cursor/rules/*.mdc` files to match the project by removing duplicates, irrelevant rules, and unnecessary examples. Update metadata for precise application.

## Steps

### 1. Detect Project Tech Stack
- Scan dependency files for frameworks and libraries
- Identify languages from file extensions
- List build tools and development tools
- Create tech stack summary

### 2. Check for Nested .cursor/rules Directories
- Search for `.cursor/rules/` directories in subdirectories (excluding root level)
- Use `find . -type d -path "*/.cursor/rules" ! -path "./.cursor/rules"`
- If nested directories found, notify user with list of locations
- Ask user what to do: merge to root, move files, or delete
- Stop and wait for user decision before proceeding

### 3. Find All Cursor Rules
- Recursively search for `.mdc` files in `.cursor/rules/`
- Use `find .cursor/rules -name "*.mdc" -type f`
- List all found rule files with paths
- Provide total count

### 4. Check for Deprecated .cursorrules File
- Search recursively for `.cursorrules` file from project root
- Use `find . -name ".cursorrules" -type f`
- If found, delete it
- Notify user about removal and migration to `.cursor/rules/*.mdc` format

### 5. Analyze Cursor Rules
- Read all `.mdc` files
- Parse YAML frontmatter metadata
- Extract rule content and purpose
- Categorize by type (language, framework, general, custom)
- Identify duplicates or overlapping rules

### 6. Request User Confirmation
Present summary:
- Current tech stack detected
- Total rules found
- Rules to remove (irrelevant to project)
- Rules to consolidate (duplicates)
- Rules to update (metadata changes)
- Rules to preserve as-is
Ask for explicit confirmation; stop if declined

### 7. Refactor Rules
- Remove rules for unused technologies
- Consolidate duplicate rules
- Trim verbose examples while keeping essential guidance
- Remove unnecessary code snippets
- Simplify complex rules
- Preserve critical project-specific rules
- Ensure clear, focused purpose
- Keep content concise and actionable

### 8. Update Rule Metadata
- Refine YAML frontmatter conditions
- Update file glob patterns to match project structure
- Set appropriate language tags
- Add or update path patterns for precise application
- Ensure metadata reflects when rules should trigger

### 9. Validate and Save
- Review refactored rules for completeness
- Ensure no critical guidance lost
- Verify metadata syntax
- Save updated `.mdc` files
- Provide summary of changes

## Checklist

- [ ] Tech stack detected
- [ ] Nested .cursor/rules directories checked and resolved
- [ ] All `.mdc` files found
- [ ] Deprecated .cursorrules file checked and removed if found
- [ ] Rules categorized by type
- [ ] Summary presented to user
- [ ] User confirmation received
- [ ] Irrelevant rules removed
- [ ] Duplicate rules consolidated
- [ ] Examples trimmed
- [ ] Metadata updated
- [ ] File globs match structure
- [ ] Changes validated and saved

