# Cursor Developer Configuration

This repository contains Cursor developer configuration with AI agent behavior policies and development workflow templates.

**Note:** This project is located in the home directory at `~/.cursor`

## Project Structure

```
.cursor/
├── .cursor/                # Internal rules for this project
│
├── commands/               # Developer Cursor commands
│
├── DEVELOPER_RULES.md      # General AI coding best practices
│
└── .gitignore             # Git configuration
```

## Available Commands

The [`commands/`](commands/) directory contains workflow templates for common development tasks:

| Command | Description |
|---------|-------------|
| [**add-test-coverage**](commands/add-test-coverage.md) | Analyze project for test coverage gaps, suggest testing frameworks if missing, identify missing tests by priority, and implement tests systematically |
| [**analyze-project-structure**](commands/analyze-project-structure.md) | Deep analysis of project structure, framework conventions, dependencies, configuration, and best practices with interactive fix recommendations |
| [**code-review**](commands/code-review.md) | Comprehensive code review process to ensure functionality, quality, security, performance, testing, and documentation meet project standards |
| [**create-pull-request**](commands/create-pull-request.md) | Create a well-structured pull request with comprehensive description, proper metadata, and review checklist to facilitate smooth code review |
| [**github-workflow-autofix**](commands/github-workflow-autofix.md) | Analyze failed GitHub workflow runs, create fix branch, automatically apply fixes, and merge back or create PR after all workflows pass |
| [**init-cursor-rules**](commands/init-cursor-rules.md) | Analyze a project and generate tech-stack-specific Cursor rules as `.mdc` files in `.cursor/rules/` directory based on detected patterns, conventions, and architecture |
| [**onboard-new-developer**](commands/onboard-new-developer.md) | Comprehensive onboarding process to get a new developer up and running with proper environment setup, project understanding, and first contribution |
| [**refactor-cursor-rules**](commands/refactor-cursor-rules.md) | Analyze project tech stack and refactor `.cursor/rules/*.mdc` files to match the project by removing duplicates, irrelevant rules, and unnecessary examples. Update metadata for precise application |
| [**run-tests-and-fix-failures**](commands/run-tests-and-fix-failures.md) | Execute full test suite, analyze failures systematically, fix issues by priority, and ensure all tests pass with proper validation |
| [**security-audit**](commands/security-audit.md) | Comprehensive security review to identify and fix vulnerabilities in dependencies, code, authentication, data handling, and infrastructure configuration |
| [**setup-new-feature**](commands/setup-new-feature.md) | Systematically set up a new feature from requirements gathering through implementation structure and testing strategy |

## Developer Rules

The [`DEVELOPER_RULES.md`](DEVELOPER_RULES.md) file contains general best practices for AI-assisted development. These rules are project-independent and should be added to Cursor as User Rules.

To apply these rules in Cursor:
1. Open Cursor Settings (⌘+, on Mac, Ctrl+, on Windows/Linux)
2. Navigate to **Rules, Memories, Commands**
3. Scroll to **User Rules** section
4. Click **+ Add Rule** button
5. Copy and paste the entire content from [`DEVELOPER_RULES.md`](DEVELOPER_RULES.md)
6. Save the rule

---

*This workspace enforces a git-only policy for AI agent access to protect privacy and security.*
