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

| Command | Description | File |
|---------|-------------|------|
| **Init Cursor Rules** | Analyze a new project from scratch and generate project-specific Cursor rules as `.mdc` files | [`init-cursor-rules.md`](commands/init-cursor-rules.md) |
| **Refactor Cursor Rules** | Analyze the project's tech stack and refactor `.cursor/rules/*.mdc` files to match the real project | [`refactor-cursor-rules.md`](commands/refactor-cursor-rules.md) |
| **GitHub Workflow Autofix** | Analyze failed GitHub workflow runs and automatically fix the issues causing failures | [`github-workflow-autofix.md`](commands/github-workflow-autofix.md) |
| **Onboard New Developer** | Comprehensive onboarding process to get a new developer up and running quickly | [`onboard-new-developer.md`](commands/onboard-new-developer.md) |
| **Setup New Feature** | Systematically set up a new feature from initial planning through to implementation structure | [`setup-new-feature.md`](commands/setup-new-feature.md) |
| **Run Tests and Fix Failures** | Execute the full test suite and systematically fix any failures | [`run-tests-and-fix-failures.md`](commands/run-tests-and-fix-failures.md) |
| **Create Pull Request** | Create a well-structured pull request with proper description, labels, and reviewers | [`create-pull-request.md`](commands/create-pull-request.md) |
| **Security Audit** | Comprehensive security review to identify and fix vulnerabilities in the codebase | [`security-audit.md`](commands/security-audit.md) |
| **Code Review** | Comprehensive checklist for conducting thorough code reviews | [`code-review.md`](commands/code-review.md) |

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
