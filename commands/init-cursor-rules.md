# Init Cursor Rules

## Overview
Analyze a project and generate tech-stack-specific Cursor rules as `.mdc` files in `.cursor/rules/` directory based on detected patterns, conventions, and architecture.

## Steps

### 1. Verify Prerequisites
- Check for `.git` directory
- Verify tracked files exist via `git ls-files`
- Exit if prerequisites not met

### 2. Detect Tech Stack
- Scan dependency files for frameworks and libraries
- Count files by language to identify primary languages
- Identify build tools, test frameworks, and databases
- Detect CI/CD configuration
- Create tech stack summary

### 3. Analyze Code Patterns
Sample 20-30 files per primary language (>5% of codebase):
- Naming conventions (variables, functions, classes, files)
- Project structure (by feature, layer, or module)
- Architecture style (MVC, layered, hexagonal, microservices)
- Import patterns (relative/absolute, ordering, aliases)
- Error handling approach
- Test structure and organization
- Documentation style
- Code formatting (check linter/formatter configs)

### 4. Request User Confirmation
Present summary:
- Detected tech stack
- Primary languages and frameworks
- Key patterns identified
- Planned `.mdc` files to generate
Ask for explicit confirmation to proceed

### 5. Generate `.cursor/rules/*.mdc` Files
- Create `.cursor/rules/` directory
- Generate `{language}.mdc` for each primary language
- Generate `{framework}.mdc` for major frameworks
- Generate `architecture.mdc` for structure patterns
- Generate `testing.mdc` for test conventions
- Generate `code-style.mdc` for formatting rules

Use YAML frontmatter with tags and globs:
```yaml
---
tags: ["language", "framework"]
globs: ["**/*.ext", "src/**/*.ext"]
---
```

### 6. Generate Summary Report
- Files analyzed count by type
- Tech stack with versions
- Generated `.mdc` files list
- Key patterns highlighted
- Ambiguities requiring clarification
- Next steps suggestions

## Best Practices

### Analysis
- Use `git ls-files` as source of truth
- Skip binary, generated, and vendor directories
- Sample intelligently across directories
- Use statistical approach for pattern detection
- Show progress for large projects (>1000 files)

### Pattern Detection
- Be context-aware (tests vs source code)
- Document conflicts when patterns split
- Provide evidence with file paths
- Focus on dominant patterns

### Rule Generation
- Base on actual project code only
- Use real examples from codebase
- Keep rules focused and actionable
- Reference existing configs
- Avoid generic advice
- Use precise tags and accurate globs

## Checklist

### Analysis
- [ ] Git repository verified
- [ ] Tracked files exist
- [ ] Tech stack detected
- [ ] Languages and frameworks identified
- [ ] Code patterns analyzed
- [ ] User confirmation received

### Generation
- [ ] `.cursor/rules/` created
- [ ] Language rules generated
- [ ] Framework rules generated
- [ ] Architecture rules created
- [ ] Testing rules created
- [ ] Code style rules created
- [ ] Summary report provided
