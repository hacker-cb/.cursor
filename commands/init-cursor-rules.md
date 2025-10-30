# Init Cursor Rules

## Overview
Analyze a new project from scratch and generate project-specific Cursor rules as `.mdc` files in `.cursor/rules/` directory. This command performs comprehensive analysis of all project code to extract tech stack, coding patterns, architecture, and conventions.

## Steps

### 1. Verify project prerequisites
   - Check if project has `.git` directory
   - Verify tracked files exist: `git ls-files | wc -l`
   - If prerequisites not met, inform user and exit

### 2. Detect tech stack
   - **Scan dependency files**: `package.json`, `requirements.txt`, `go.mod`, `Cargo.toml`, `pom.xml`, `Gemfile`, `composer.json`, etc.
   - **Count files by language**: `git ls-files | grep -E '\.([a-z]+)$' | sed 's/.*\.//' | sort | uniq -c | sort -rn`
   - **Extract frameworks and libraries**: Parse dependency files for major frameworks (React, Django, Express, Rails, FastAPI, etc.)
   - **Identify build tools**: webpack, vite, rollup, Make, Gradle, etc.
   - **Detect test frameworks**: Jest, pytest, RSpec, etc.
   - **Find databases**: Check for ORM packages and config files
   - **Detect CI/CD**: `.github/workflows/`, `.gitlab-ci.yml`, etc.
   - Create summary of detected tech stack

### 3. Analyze code patterns
For each primary language (>5% of project files), analyze sample of 20-30 files:

   - **Naming conventions**: Variable, function, class, constant, and file naming patterns (camelCase, snake_case, PascalCase, kebab-case)
   - **Project structure**: Map directory tree and identify organization pattern (by feature, by layer, by module)
   - **Architecture style**: Identify MVC, layered, hexagonal, microservices, etc.
   - **Import patterns**: Relative vs absolute, import ordering, grouping, path aliases
   - **Error handling**: Try-catch patterns, exception types, error logging approach
   - **Test structure**: Test file location and naming, test organization (AAA, describe/it), mocking patterns
   - **Documentation**: Comment density, docstring style (Google, JSDoc, etc.), inline documentation
   - **Code style**: Check for linter/formatter configs (`.eslintrc`, `.prettierrc`, `pyproject.toml`, etc.)
   - **Indentation and formatting**: Spaces/tabs, line length, bracket styles, trailing commas

### 4. Request user confirmation
   - Present analysis summary:
     - Tech stack detected
     - Primary languages and frameworks
     - Key patterns identified
     - `.mdc` files to be generated
   - Show list of planned rule files
   - Ask for explicit confirmation to proceed
   - If user declines, stop execution

### 5. Generate `.cursor/rules/*.mdc` files
   - Create `.cursor/rules/` directory if it doesn't exist
   - Generate language-specific rules: `{language}.mdc` for each primary language
   - Generate framework-specific rules: `{framework}.mdc` for major frameworks
   - Generate `architecture.mdc`: Project structure and organization patterns
   - Generate `testing.mdc`: Test conventions and patterns
   - Generate `code-style.mdc`: Formatting and style rules

Each `.mdc` file should include:
```yaml
---
tags: ["relevant", "tags"]
globs: ["**/*.ext", "src/**/*.ext"]
---

# {Category} Rules for {Project}

## Detected Patterns
{Brief description of patterns found in project}

## Naming Conventions
{Actual patterns from project with examples}

## Code Organization
{How code is structured in this project}

## Best Practices
{Based on actual project patterns, not generic advice}
```

### 6. Generate summary report
   - **Files analyzed**: Total counts by type
   - **Tech stack summary**: Languages, frameworks, tools with versions
   - **Generated rules**: List all created `.mdc` files
   - **Key patterns**: Highlight most important detected patterns
   - **Ambiguities**: Note any conflicting patterns that need user clarification
   - **Next steps**: Suggest reviewing rules, testing with code generation, and adding to git

## Implementation Guidelines

### Analysis Approach
- Use `git ls-files` as source of truth for all file operations
- For large projects (1000+ files), show progress every 100 files
- Skip binary files, generated directories (dist/, build/, node_modules/), and vendor code
- Sample intelligently: ensure representative coverage across directories
- Use statistical approach: count pattern occurrences, use majority pattern

### Pattern Detection
- Be context-aware: tests may have different patterns than source code
- Document conflicts: if patterns split 40/60, note both and ask user
- Provide evidence: include file paths and example lines for detected patterns
- Focus on consistency: identify the dominant pattern used in project

### Rule Generation
- **Project-specific only**: Base all rules on actual project code analysis
- **Use real examples**: Include code examples from the actual project
- **Be concise**: Keep rules focused and actionable
- **Reference configs**: Point to existing linter/formatter configs when present
- **Avoid generic advice**: Every rule must be grounded in project analysis

### MDC Metadata
- **Precise tags**: Match project's actual tech stack
- **Accurate globs**: Reflect actual project directory structure
- **Multiple paths**: Include all relevant paths (src/, app/, lib/, tests/)

## Init Checklist

### Prerequisites
- [ ] Git repository verified
- [ ] Tracked files exist

### Tech Stack Detection
- [ ] Dependency files scanned
- [ ] Language distribution calculated
- [ ] Frameworks identified
- [ ] Build and test tools detected
- [ ] Tech stack summary created

### Pattern Analysis
- [ ] Naming conventions analyzed per language
- [ ] Project structure mapped
- [ ] Architecture pattern identified
- [ ] Import patterns documented
- [ ] Error handling patterns noted
- [ ] Test patterns analyzed
- [ ] Documentation style identified
- [ ] Code style patterns detected

### User Confirmation
- [ ] Analysis summary presented
- [ ] User confirmation received

### Rule Generation
- [ ] `.cursor/rules/` directory created
- [ ] Language `.mdc` files generated
- [ ] Framework `.mdc` files generated
- [ ] `architecture.mdc` created
- [ ] `testing.mdc` created
- [ ] `code-style.mdc` created

### Completion
- [ ] Summary report generated
- [ ] Files analyzed count provided
- [ ] Key patterns highlighted
- [ ] Next steps suggested
